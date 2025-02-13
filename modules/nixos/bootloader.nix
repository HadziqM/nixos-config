{ nix, boot, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "amd_pstate=active" # powerstate
      "processor.max_cstate=5" # limit power usage
      "nvme.noacpi=1" # NVME power management
    ];
    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot.enable = false;

      grub = {
        enable = true; # This is missing
        efiSupport = true;
        #efiInstallAsRemovable = true; # Uncomment if needed
        device = "nodev"; # EFI systems don't use a physical device
        useOSProber = false; # Detects other OSes like Windows
        configurationLimit = 10; # Keep only 5 boot generations
      };
    };
  };
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };
}
