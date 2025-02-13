{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      font-awesome
      fira-sans
      roboto
    ];
    fontconfig.enable = true;
  };
}

