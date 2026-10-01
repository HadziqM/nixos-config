{
  pkgs,
  ...
}:
{
  programs.noctalia = {
    enable = true;
  };

  files.".config/noctalia/config.toml".source = ./noctalia-config.toml;

  packages = with pkgs; [
    proton-vpn-cli
    adw-gtk3
    nwg-look
    glib
  ];
}
