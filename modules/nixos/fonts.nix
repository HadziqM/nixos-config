{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
      dejavu_fonts
      noto-fonts
      noto-fonts-emoji
    ];
    fontconfig.enable = true;
  };
}

