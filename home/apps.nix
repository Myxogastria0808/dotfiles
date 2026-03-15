{
  pkgs,
  inputs,
  desktopEnvironment,
  ...
}:
{
  imports = [
    # Archived home-manager configs (kept for reference, moved to system modules or replaced)
    # ./config/.archive/starship.nix  # Moved to modules/config/starship.nix
    # ./config/.archive/zsh.nix       # Moved to modules/config/zsh.nix
    # ./config/.archive/alacritty.nix # Replaced by Ghostty
    # ./config/.archive/television    # No longer used
    # ./config/.archive/vscode.nix    # Moved to modules/app.nix
    ./config/ghostty
    ./config/skk
    ./config/firefox
  ]
  ++ [ ./config/hyprland ];
  # Hyprland home-manager config (Waybar, keybindings, tools) is only loaded
  # when the active desktop environment is Hyprland. When using KDE or COSMIC,
  # this block is omitted automatically — no manual commenting out required.
  # ++ (if desktopEnvironment == "hyprland" then [ ./config/hyprland ] else [ ]);
  # User-level packages managed by home-manager
  home.packages = with pkgs; [ ];
}
