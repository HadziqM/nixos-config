{
  pkgs,
  ...
}:
{
  # IMPORTANT dont import this nix module
  # this does nothing on wayland
  # on x11 use the default driver `modsetting`
  services.xserver.videoDrivers = [ "amdgpu" ];
}
