{ ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports for Steam Remote Play (stream games to other devices)
    dedicatedServer.openFirewall = true; # Open ports for Source Dedicated Server (CS, TF2, etc.)
    localNetworkGameTransfers.openFirewall = true; # Open ports for local network game file transfers
  };
}
