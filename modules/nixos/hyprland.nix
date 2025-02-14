{ config, pkgs, ... }:

{
  services.xserver.displayManager.gdm.wayland = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };


  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };

  environment.systemPackages = with pkgs; [
    waybar
    eww
    dunst
    libnotify
    waypaper
    kitty
    rofi-wayland

    hyprshot
    hypridle
    grim
    slurp
    waybar
    hyprpanel
    dunst
    wl-clipboard
    swaynotificationcenter
  ];
}

