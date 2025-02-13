{ pkgs, config, ... }:
{

  imports = [
    ../modules/home-manager/git.nix
    ../modules/home-manager/nvim/conf.nix
    ../modules/home-manager/zsh/conf.nix
    ../modules/home-manager/tmux/conf.nix
    # ../config/wlogout.nix
    # ../config/rofi/rofi.nix
  ];


  home.username = "hadziq";
  home.homeDirectory = "/home/hadziq";

  programs.bash.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    htop
    spotify
    legcord
  ];


  stylix.targets.waybar.enable = false;

  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # qt = {
  #   enable = true;
  #   # style.name = "adwaita-dark";
  #   platformTheme.name = "gtk3";
  # };

  home.stateVersion = "25.05"; # Make sure to set this to your NixOS version
}
