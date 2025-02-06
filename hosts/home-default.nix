{ pkgs, ... }: 
{

  imports = [
    ../modules/home-manager/git.nix
    ../modules/home-manager/nvim/conf.nix
    ../modules/home-manager/zsh/conf.nix
    ../modules/home-manager/tmux/conf.nix
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

  home.stateVersion = "25.05"; # Make sure to set this to your NixOS version
}
