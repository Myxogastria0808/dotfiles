{ pkgs, ... }:
{
  imports = [
    ./kde
    ./cosmic
    ./hyprland
  ];

  # ── Display Manager ───────────────────────────────────────────────────────────
  # XServer is required to run SDDM even on Wayland sessions
  services.xserver.enable = true;
  # SDDM is the shared display manager for KDE, COSMIC, and Hyprland sessions
  services.displayManager.sddm.enable = true;
  # Default session: hyprland-uwsm (UWSM-managed Hyprland — recommended)
  # NOTE: "hyprland" (standalone, without UWSM) is also registered as a session by the
  # NixOS Hyprland module and will appear in the SDDM session list, but it is NOT the
  # default and its stability is not guaranteed. Use "hyprland-uwsm" for reliable operation.
  # Other options: "plasmax11" (KDE X11), "plasma" (KDE Wayland)
  services.displayManager.defaultSession = "hyprland-uwsm";

  # To replace SDDM with the COSMIC greeter instead:
  #   1. Set services.displayManager.sddm.enable = false above
  #   2. Uncomment the line below
  # services.displayManager.cosmic-greeter.enable = true;

  # XWayland allows X11 apps to run inside a Wayland session
  programs.xwayland.enable = true;

  # ── XDG Desktop Portal ────────────────────────────────────────────────────────
  # Ref: https://wiki.hypr.land/Hypr-Ecosystem/xdg-desktop-portal-hyprland/
  # Ref: https://wiki.archlinux.org/title/XDG_Desktop_Portal
  # Ref: https://flatpak.github.io/xdg-desktop-portal/
  #
  # ── Why this is needed: X11 vs Wayland ──────────────────────────────────────
  #
  # Under X11, any application could freely access the display server directly.
  # This made features like screen capture and file dialogs easy to implement,
  # but it also meant any app could spy on other windows, intercept keystrokes,
  # or access the filesystem without the user's knowledge — a serious security risk.
  #
  #   X11 model (unrestricted):
  #
  #   ┌───────────┐     direct access    ┌─────────────────┐
  #   │    App    │ ───────────────────► │   X11 Server /  │
  #   │ (Firefox) │                      │   Filesystem /  │
  #   └───────────┘                      │   Other Windows │
  #                                      └─────────────────┘
  #
  # Wayland was designed to fix this by strictly sandboxing every application.
  # Each app can only see and control its own windows — nothing else.
  # The compositor (e.g. Hyprland) manages everything, but apps cannot
  # reach it directly. This is secure, but it breaks features that depend
  # on cross-app or compositor-level access.
  #
  #   Wayland model (sandboxed):
  #
  #   ┌───────────┐      blocked!        ┌──────────────────┐
  #   │    App    │ ──── ✗ ────────────► │   Hyprland /     │
  #   │ (Firefox) │                      │   Filesystem /   │
  #   └───────────┘                      │   Other Windows  │
  #                                      └──────────────────┘
  #
  # ── The solution: xdg-desktop-portal as a trusted broker ────────────────────
  #
  # xdg-desktop-portal (XDP) sits between apps and the compositor,
  # acting as a trusted intermediary. Apps send requests over D-Bus
  # (Linux's inter-process message bus), and XDP forwards them to the
  # appropriate backend, which actually talks to the compositor or OS.
  #
  #   Wayland model with xdg-desktop-portal:
  #
  #   ┌───────────┐               ┌──────────────────────┐               ┌─────────────────┐
  #   │    App    │   D-Bus msg   │  xdg-desktop-portal  │   delegates   │ portal backend  │
  #   │ (Firefox) │ ────────────► │   (trusted broker)   │ ────────────► │ (talks to DE)   │
  #   └───────────┘               └──────────────────────┘               └─────────────────┘
  #
  # ── Portal backends (implementations) ───────────────────────────────────────
  #
  # xdg-desktop-portal by itself does not implement any feature.
  # The actual work is done by "backends", each covering a different set
  # of D-Bus interfaces. No single backend covers everything, so multiple
  # backends coexist and complement each other:
  #
  #   ┌──────────────────────────────┬─────────────────────────────────────────────────────┐
  #   │ D-Bus Interface              │ Handled by                                          │
  #   ├──────────────────────────────┼─────────────────────────────────────────────────────┤
  #   │ ScreenCopy (screen sharing)  │ xdg-desktop-portal-hyprland  (compositor access)    │
  #   │ Screenshot                   │ xdg-desktop-portal-hyprland  (compositor access)    │
  #   │ GlobalShortcuts              │ xdg-desktop-portal-hyprland  (compositor access)    │
  #   │ FileChooser (file dialogs)   │ xdg-desktop-portal-gtk       (compositor-agnostic)  │
  #   │ OpenURI (open with...)       │ xdg-desktop-portal-gtk       (compositor-agnostic)  │
  #   │ Settings (theme/font/color)  │ xdg-desktop-portal-gtk       (compositor-agnostic)  │
  #   └──────────────────────────────┴─────────────────────────────────────────────────────┘
  #
  # xdg-desktop-portal-hyprland handles interfaces that require direct access to Hyprland
  # (e.g. capturing the screen, registering global shortcuts). It is automatically added
  # by the NixOS Hyprland module when programs.hyprland.enable = true, so it does not
  # need to be listed here explicitly.
  #
  # xdg-desktop-portal-gtk handles interfaces that are compositor-agnostic
  # (e.g. showing a GTK file picker, reading GTK theme settings). It works on any
  # desktop environment and serves as the essential fallback for everything
  # xdg-desktop-portal-hyprland does not implement.
  #
  # ── Request resolution: how XDP picks a backend ─────────────────────────────
  #
  # NixOS auto-generates /etc/xdg/xdg-hyprland/hyprland-portals.conf:
  #
  #   [preferred]
  #   default=hyprland;gtk     ← try xdg-desktop-portal-hyprland first, then xdg-desktop-portal-gtk
  #
  # ── Concrete example 1: "Firefox opens a file dialog" ───────────────────────
  #
  #   1. User clicks "Open File" in Firefox
  #   2. Firefox sends:  org.freedesktop.portal.FileChooser.OpenFile  over D-Bus
  #   3. XDP checks hyprland-portals.conf: try xdg-desktop-portal-hyprland first
  #   4. xdg-desktop-portal-hyprland: "I do not implement FileChooser" → skipped
  #   5. XDP falls back to xdg-desktop-portal-gtk
  #   6. xdg-desktop-portal-gtk: "I implement FileChooser" → GTK file picker opens ✓
  #
  # ── Concrete example 2: "Discord shares the screen" ─────────────────────────
  #
  #   1. User clicks "Share Screen" in Discord
  #   2. Discord sends:  org.freedesktop.portal.ScreenCast.CreateSession  over D-Bus
  #   3. XDP checks hyprland-portals.conf: try xdg-desktop-portal-hyprland first
  #   4. xdg-desktop-portal-hyprland: "I implement ScreenCast" → asks Hyprland for
  #      the screen buffer and streams it back to Discord ✓
  #      (xdg-desktop-portal-gtk is never consulted)
  #
  # ── What happens WITHOUT xdg-desktop-portal-gtk ─────────────────────────────
  #
  #   1. Firefox sends FileChooser.OpenFile over D-Bus
  #   2. xdg-desktop-portal-hyprland: "I do not implement FileChooser" → skipped
  #   3. No other backend exists → XDP waits for a response that never comes
  #   4. After 5–30 seconds, the request times out
  #
  # This timeout happens before the app window even appears, so every app that
  # uses FileChooser, OpenURI, or Settings will feel frozen at startup.
  # Adding xdg-desktop-portal-gtk as a fallback prevents this entirely.
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  # NOTE: check performance
  # xdg-document-portal (Flatpak) ignores SIGTERM on logout, causing a 90s
  # wait before systemd sends SIGKILL. Set TimeoutStopSec to 1 (minimum) so
  # SIGKILL is sent immediately after SIGTERM with no meaningful delay.
  # systemd.user.services.xdg-document-portal = {
  #   serviceConfig.TimeoutStopSec = 1;
  # };

  # US keyboard layout for X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
