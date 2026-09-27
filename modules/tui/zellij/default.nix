{ pkgs, ... }:

{
  packages = with pkgs; [
    zellij
  ];

  files.".config/zellij/config.kdl".text = ''
    show_startup_tips false
    theme "noctalia"
  '';

}
