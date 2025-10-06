{
  imports = [
    ../default.nix
    ./hardware-configuration.nix
    ../../modules/nixos/binary-cache.nix
    ../../modules/nixos/android-dev.nix
  ];
  networking.hostName = "hadziq-pc";
}
