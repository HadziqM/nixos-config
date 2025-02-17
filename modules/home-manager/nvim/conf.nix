{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep
    fd
    nodejs # For LSPs
    python3
    gcc # Needed for Treesitter
    xclip
    fzf
    lazygit
  ];


  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile."nvim" = {
    source = ../../../dotfiles/.config/nvim; # Adjust path
    recursive = true;
  };


  home.sessionVariables = {
    EDITOR = "nvim";
  };
}

