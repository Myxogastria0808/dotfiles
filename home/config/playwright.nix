{ pkgs, ... }: {
  home.packages = with pkgs; [
    playwright
    playwright-driver.browsers
  ];
}