{ pkgs, inputs, ... }:
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
  ];
  # User-level packages managed by home-manager
  home.packages = with pkgs; [
    # Browser
    # inputs.zen-browser.packages."${pkgs.system}".default
  ];
}
