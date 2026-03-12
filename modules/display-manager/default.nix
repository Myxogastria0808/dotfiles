{ ... }:
{
  imports = [
    ./kde
    ./cosmic
    ./hyprland
  ];

  # ── Display Manager ───────────────────────────────────────────────────────────
  # XServer is required to run SDDM even on Wayland sessions
  services.xserver.enable = true;
  # SDDM is the shared display manager for both KDE and COSMIC sessions
  services.displayManager.sddm.enable = true;
  # Default session: hyprland (use "plasmax11" for KDE X11, "plasma" for KDE Wayland)
  services.displayManager.defaultSession = "hyprland";

  # To replace SDDM with the COSMIC greeter instead:
  #   1. Set services.displayManager.sddm.enable = false above
  #   2. Uncomment the line below
  # services.displayManager.cosmic-greeter.enable = true;

  # XWayland allows X11 apps to run inside a Wayland session
  programs.xwayland.enable = true;

  # Required by Flatpak for sandboxed file chooser, screenshot, etc.
  xdg.portal = {
    enable = true;
    # extraPortals = with pkgs; [
    #   xdg-desktop-portal-gtk  # Add this on non-KDE/GNOME desktops
    # ];
  };

  # US keyboard layout for X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
