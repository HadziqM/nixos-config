{ pkgs, config, ... }:
{

  imports = [
    # ../modules/home-manager/git.nix
    # ../modules/home-manager/nvim/conf.nix
    # ../modules/home-manager/zsh/conf.nix
    # ../modules/home-manager/tmux/conf.nix
    ../config/wlogout.nix
    ../config/rofi/rofi.nix
  ];


  home.username = "hadziq";
  home.homeDirectory = "/home/hadziq";

  programs.bash.enable = true;



  home.file = {
    # Hyprland Config
    ".config/hypr".source = ../dotfiles/.config/hypr;
    # wlogout icons
    ".config/wlogout/icons".source = ../config/wlogout;

    # Top Level Files symlinks
    ".zshrc".source = ../dotfiles/.zshrc;
    ".gitconfig".source = ../dotfiles/.gitconfig;
    ".ideavimrc".source = ../dotfiles/.ideavimrc;
    ".nirc".source = ../dotfiles/.nirc;
    ".local/bin/wallpaper".source = ../dotfiles/.local/bin/wallpaper;

    # Config directories
    ".config/dunst".source = ../dotfiles/.config/dunst;
    ".config/fastfetch".source = ../dotfiles/.config/fastfetch;
    ".config/kitty".source = ../dotfiles/.config/kitty;
    ".config/mpv".source = ../dotfiles/.config/mpv;
    ".config/tmux/tmux.conf".source = ../dotfiles/.config/tmux/tmux.conf;
    ".config/waybar".source = ../dotfiles/.config/waybar;
    ".config/yazi".source = ../dotfiles/.config/yazi;
    ".config/wezterm".source = ../dotfiles/.config/wezterm;
    ".config/zsh".source = ../dotfiles/.config/zsh;
    ".config/nvim".source = ../dotfiles/.config/nvim;

    # Individual config files
    ".config/kwalletrc".source = ../dotfiles/.config/kwalletrc;
    ".config/starship.toml".source = ../dotfiles/.config/starship.toml;

    # zsh plugins
    ".local/share/zsh/plugins/zsh-autosuggestions".source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
    ".local/share/zsh/plugins/zsh-syntax-highlighting".source = "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting";
    ".local/share/zsh/plugins/zsh-history-substring-search".source = "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search";
  };

  home.sessionVariables = {
    # Default applications
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "kitty";
    BROWSER = "zen";

    # XDG Base Directories
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_SCREENSHOTS_DIR = "$HOME/Pictures/screenshots";

    # Path modifications - now as a string
    # PATH = "$HOME/.local/bin:$HOME/go/bin:$PATH";

    # Wayland and Hyprland specific
    JAVA_AWT_WM_NOREPARENTING = 1;
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";

    # Localization
    LC_ALL = "en_US.UTF-8";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "$HOME/.cargo/bin"
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    ripgrep
    fd
    nodejs # For LSPs
    python3
    gcc # Needed for Treesitter
    xclip
    fzf
    lazygit
    spotify
    legcord
    (import ../scripts/rofi-launcher.nix { inherit pkgs; })
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

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
