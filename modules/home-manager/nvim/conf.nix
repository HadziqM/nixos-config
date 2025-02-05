{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    ripgrep
    fd
    nodejs  # For LSPs
    python3
    gcc  # Needed for Treesitter
  ];


  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile."nvim" = {
    source = ./config;  # Adjust path
    recursive = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}

