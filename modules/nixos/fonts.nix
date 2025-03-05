{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      pkgs.nerd-fonts.jetbrains-mono
      noto-fonts-emoji
      fira-sans
      roboto
      noto-fonts-cjk-sans
      font-awesome
      material-icons
    ];
    fontconfig.enable = true;
  };
}
