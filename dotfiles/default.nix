{ pkgs, ... }:
{
  home = {
    file = {
      # Top Level Files symlinks
      ".ideavimrc".source = ./.ideavimrc;

      # Config directories
      # ".config/staship.toml".source = ../dotfiles/.config/starship.toml;
      ".config/fastfetch".source = ./.config/fastfetch;
      ".config/kitty".source = ../dotfiles/.config/kitty;
      ".config/tmux/tmux.conf".source = ./.config/tmux/tmux.conf;
      ".config/yazi".source = ./.config/yazi;
    };

  };

  home.packages = with pkgs; [
    bat
    eza
    yazi
    tmux
    zsh
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-history-substring-search
  ];

  # programs.zsh.enable = true;

  home.file = {
    ".zshrc".source = ./.zshrc;
    ".local/share/zsh/plugins/zsh-autosuggestions".source =
      "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
    ".local/share/zsh/plugins/zsh-syntax-highlighting".source =
      "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting";
    ".local/share/zsh/plugins/zsh-history-substring-search".source =
      "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search";
  };

  xdg.configFile."zsh" = {
    source = ./.config/zsh; # Adjust path
    recursive = true;
  };

}
