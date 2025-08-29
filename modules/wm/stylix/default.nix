{ pkgs, ... }:
{
  stylix = {
    enable = true;
    image = ../../../asset/neon.jpg;
    base16Scheme = ./mocha.yml;
    polarity = "dark";
    opacity.terminal = 0.8;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };
}
