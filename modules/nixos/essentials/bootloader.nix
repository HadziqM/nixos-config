{
  conf,
  pkgs,
  ...
}:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "amd_pstate=active" # powerstate
      "processor.max_cstate=5" # limit power usage
      "nvme.noacpi=1" # NVME power management
      "v4l2loopback" # virtual cam
    ];
    extraModulePackages = [ pkgs.linuxKernel.packages.linux_zen.v4l2loopback ];
    tmp.cleanOnBoot = true;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        inherit (conf) efiSysMountPoint;
      };

      systemd-boot.enable = false;

      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        inherit (conf) useOSProber;
        configurationLimit = 10;
      };
    };
  };
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };
}
