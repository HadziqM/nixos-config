{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    eza
  ];

  home.file = {
    ".zshrc".source = ../../dotfiles/.config/.zshrc;
    ".local/share/zsh/plugins/zsh-autosuggestions".source =
      "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
    ".local/share/zsh/plugins/zsh-syntax-highlighting".source =
      "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting";
    ".local/share/zsh/plugins/zsh-history-substring-search".source =
      "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search";
  };

  xdg.configFile."zsh" = {
    source = ../../dotfiles/.config/zsh; # Adjust path
    recursive = true;
  };
}
