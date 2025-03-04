{
  pkgs,
  inputs,
  ...
}:
let
  conf = builtins.fromJSON (builtins.readFile ../setting.json);
in
{

  imports = [
    ../modules/home-manager/direnv.nix
    ../modules/home-manager/zsh.nix
    ../modules/home-manager/git.nix
  ];

  home = {
    username = "${conf.user}";
    homeDirectory = "/home/${conf.user}";
    file = {
      # Top Level Files symlinks
      ".ideavimrc".source = ../dotfiles/.ideavimrc;

      # Config directories
      ".config/fastfetch".source = ../dotfiles/.config/fastfetch;
      ".config/kitty".source = ../dotfiles/.config/kitty;
      ".config/tmux/tmux.conf".source = ../dotfiles/.config/tmux/tmux.conf;
      ".config/yazi".source = ../dotfiles/.config/yazi;
    };
    sessionVariables = {
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

      # Localization
      LC_ALL = "en_US.UTF-8";
    };
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/go/bin"
      "$HOME/.cargo/bin"
    ];
    packages = with pkgs; [
      xclip
      lazygit
      legcord
      # my NixVim configuration
      inputs.Akari.packages.${system}.default
      spotify
    ];
  };

  nixpkgs.config.allowUnfree = true;

  gtk = {
    theme = {
      name = "Cyberpunk Neon";
      package = pkgs.cyberpunk-neon;
    };
    iconTheme = {
      name = "Candy Icons";
      package = pkgs.candy-icons;
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
