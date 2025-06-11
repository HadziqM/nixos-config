{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ac6bd71d-951b-4049-b9fc-e80ddc1cc5dc";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/525E-8092";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems = {
    "/extdisk/work" = {
      device = "/dev/disk/by-uuid/BA6A83DC6A839433";
      fsType = "ntfs";
      options = [
        "defaults"
        "nofail"
        "x-systemd.automount"
        "x-systemd.device-timeout=5"
        "uid=1000" # if you need specific ownership
        "gid=100"
        "x-gvfs-show"
        "x-gvfs-name=work"
      ];
    };
    "/extdisk/media" = {
      device = "/dev/disk/by-uuid/4E759590173BA01C";
      fsType = "ntfs";
      options = [
        "defaults"
        "nofail"
        "x-systemd.automount"
        "x-systemd.device-timeout=5"
        "x-gvfs-show"
        "x-gvfs-name=media"
        "uid=1000" # if you need specific ownership
        "gid=100"
      ];
    };
    "/extdisk/extrassd" = {
      device = "/dev/disk/by-uuid/add55c2c-0a5c-4fb2-90cd-c3cdce395d16";
      fsType = "ext4";
      options = [
        "defaults"
        "nofail"
        "x-systemd.automount"
        "x-systemd.device-timeout=5"
        "x-gvfs-show"
        "x-gvfs-name=extrassd"
      ];
    };
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0f0u2u4.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
