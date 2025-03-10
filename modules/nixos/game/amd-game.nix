{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
  environment.systemPackages = with pkgs; [
    wine
    wine64
    winetricks
    gamemode
    gamescope
  ];
}
