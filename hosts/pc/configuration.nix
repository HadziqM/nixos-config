{ pkgs, lib, ... }:

{
  imports = [
    ../default.nix
    ./hardware-configuration.nix
    ../../modules/nixos/binary-cache.nix
    # ../../modules/nixos/android-dev.nix
  ];
  networking.hostName = "hadziq-pc";

  services.power-profiles-daemon.enable = true;
  services.auto-cpufreq.enable = lib.mkForce false;
  powerManagement.powertop.enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    android-studio
    flutter
  ];
}
