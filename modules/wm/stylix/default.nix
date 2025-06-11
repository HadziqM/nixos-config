{ pkgs, lib, ... }:
{
  stylix = {
    enable = true;
    image = ../../../neon.jpg;
    base16Scheme = {
      base00 = "0d0f18"; # Background (very dark)
      base01 = "161a2a"; # Lighter background
      base02 = "21273e"; # Selection background
      base03 = "2e384f"; # Comments/dimmed
      base04 = "4b5278"; # Dark foreground
      base05 = "a6b3cc"; # Default foreground
      base06 = "d7dce2"; # Bright foreground
      base07 = "f0f4f8"; # Bright white
      base08 = "ff5370"; # Red (Error/Warning)
      base09 = "ffcb6b"; # Orange
      base0A = "f78c6c"; # Yellow
      base0B = "c3e88d"; # Green
      base0C = "89ddff"; # Cyan
      base0D = "82aaff"; # Blue
      base0E = "c792ea"; # Purple
      base0F = "ff869a"; # Bright red
    };
    polarity = "dark";
    opacity.terminal = 0.8;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    targets.qt.platform = lib.mkForce "qtct";
    # fonts = {
    #   monospace = {
    #     package = pkgs.nerd-fonts.fira-mono;
    #     name = "Fira Mono";
    #   };
    #   sansSerif = {
    #     package = pkgs.montserrat;
    #     name = "Montserrat";
    #   };
    #   serif = {
    #     package = pkgs.montserrat;
    #     name = "Montserrat";
    #   };
    #   sizes = {
    #     applications = 12;
    #     terminal = 15;
    #     desktop = 11;
    #     popups = 12;
    #   };
    # };

  };
}
