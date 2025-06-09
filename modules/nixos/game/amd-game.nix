{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    winetricks
    gamemode
    gamescope
    lutris
  ];
}
