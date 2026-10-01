{
  conf,
  pkgs,
  ...
}:
{
  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = [ conf.user ];

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      vhostUserPackages = [ pkgs.virtiofsd ];
    };
  };

  virtualisation.spiceUSBRedirection.enable = true;
}
