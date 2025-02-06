{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
  };

  xdg.configFile."tmux" = {
    source = ./config;  # Adjust path
    recursive = true;
  };
}

