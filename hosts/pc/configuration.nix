{
  imports = [
    ../default.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "hadziq-pc";
}
