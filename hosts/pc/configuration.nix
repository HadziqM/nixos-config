{
  imports = [
    ../default.nix
    ./hardware-configuration.nix
    ../../modules/nixos/binary-cache.nix
  ];

  networking.hostName = "hadziq-pc";
}
