{ config, pkgs, ... }:

{
  services.xserver.displayManager.gdm.wayland = true;  

  programs.hyprland = {
      enable = true;
      xwayland.enable = true;
  };


  environment.systemPackages = with pkgs; [
    waybar
    eww
    dunst
    libnotify
    xdg-desktop-portal-gtk
    waypaper
    kitty
    rofi-wayland
    wofi
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}

