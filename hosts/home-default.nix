{
  pkgs,
  inputs,
  ...
}:
let
  conf = builtins.fromJSON (builtins.readFile ../setting.json);
  inherit (pkgs) jdk;
in
{

  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    # ../modules/home-manager/direnv.nix
    ../modules/home-manager/zsh.nix
    ../modules/home-manager/git.nix
    ../modules/home-manager/spotify.nix
    # ../modules/home-manager/rust.nix
  ];

  home = {
    username = "${conf.user}";
    homeDirectory = "/home/${conf.user}";
    file = {
      # Top Level Files symlinks
      ".ideavimrc".source = ../dotfiles/.ideavimrc;

      # Config directories
      ".config/staship.toml".source = ../dotfiles/.config/starship.toml;
      ".config/fastfetch".source = ../dotfiles/.config/fastfetch;
      ".config/kitty".source = ../dotfiles/.config/kitty;
      ".config/tmux/tmux.conf".source = ../dotfiles/.config/tmux/tmux.conf;
      ".config/yazi".source = ../dotfiles/.config/yazi;
    };
    sessionVariables = {
      # Default applications

      JAVA_HOME = "${jdk.home}";

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
      jdk
      bundletool
      # my NixVim configuration
      inputs.Akari.packages.${system}.default
    ];
  };

  nixpkgs.config.allowUnfree = true;

  gtk = {
    # theme = {
    #   name = lib.mkForce "Cyberpunk Neon";
    #   package = lib.mkForce pkgs.cyberpunk-neon.gtk;
    # };
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
