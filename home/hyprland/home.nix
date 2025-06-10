{
  pkgs,
  inputs,
  conf,
  ...
}:
{

  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/spotify.nix
    ../../dotfiles

    ../../modules/tui/scripts
    ../../modules/tui/cli-tools
    ../../modules/tui/starship
    ../../modules/tui/fish
    # Personal laptop modules
    ../../modules/wm/hyprland/home.nix
    ../../modules/wm/ags
    ../../modules/wm/quickshell
    ../../modules/wm/dunst
    ../../modules/tui/kitty
    ../../modules/gui/zen-browser
    ../../modules/gui/vesktop
    ../../modules/gui/apps

  ];

  home = {
    username = "${conf.user}";
    homeDirectory = "/home/${conf.user}";
    sessionVariables = {
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
      # my NixVim configuration
      inputs.Akari.packages.${system}.default
    ];
  };

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "25.05"; # Make sure to set this to your NixOS version
}
