{ pkgs, lib, ... }:
{
  stylix = {
    enable = true;
    image = ../../../neon.jpg;
    base16Scheme = {
      base00 = "0f0f17"; # Background (Deep Black)
      base01 = "1a1d2a"; # Lighter Black
      base02 = "282c3a"; # Selection Background
      base03 = "3e4451"; # Comments / Secondary Text
      base04 = "ffcc66"; # Bright Yellow
      base05 = "c3c7d1"; # Default Foreground (Light Gray)
      base06 = "ff78c6"; # Neon Pink
      base07 = "00ff9f"; # Cyber Green
      base08 = "ff5555"; # Bright Red
      base09 = "ffcc66"; # Gold/Orange
      base0A = "ffcc00"; # Bright Gold
      base0B = "00ff9f"; # **Neon Green**
      base0C = "00c8ff"; # **Cyan-Blue**
      base0D = "0088ff"; # **Bright Blue**
      base0E = "9a00ff"; # **Deep Violet**
      base0F = "ff0077"; # **Pinkish Magenta**
    };
    polarity = "dark";
    opacity.terminal = 0.8;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    targets.qt.platform = lib.mkForce "qtct";
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-mono;
        name = "Fira Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 11;
        popups = 12;
      };
    };
  };
}
