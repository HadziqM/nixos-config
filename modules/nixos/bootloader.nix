{ nix, boot, ... }:

{
  boot.loader = {
    efi.canTouchEfiVariables = true;

    systemd-boot.enable = false;

    grub = {
      enable = true;  # This is missing
      efiSupport = true;
      #efiInstallAsRemovable = true; # Uncomment if needed
      device = "nodev";  # EFI systems don't use a physical device
      useOSProber = true;  # Detects other OSes like Windows
      configurationLimit = 10;  # Keep only 5 boot generations
    };
  };

  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };
}
