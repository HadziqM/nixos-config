{
  conf,
  pkgs,
  ...
}:
{
  boot = {
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
    kernelParams = [
      "amd_pstate=active" # powerstate
      "processor.max_cstate=5" # limit power usage
      "nvme.noacpi=1" # NVME power management
    ];
    kernelModules = [ "v4l2loopback" ];

    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="Samsung Virtual Cam"
    '';
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

  # nix.gc = {
  #   automatic = true;
  #   options = "--delete-older-than 14d";
  # };
}
