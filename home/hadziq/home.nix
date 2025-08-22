{
  pkgs,
  inputs,
  conf,
  ...
}:
{

  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    inputs.catppuccin.homeModules.catppuccin
    ../../dotfiles

    ../../modules/wm/niri
    ../../modules/wm/eww
    ../../modules/wm/quickshell

    ../../modules/gui/zen-browser
    ../../modules/gui/vesktop
    ../../modules/gui/spotify
    ../../modules/gui/apps

    ../../modules/tui/cli-tools
    ../../modules/tui/starship
    ../../modules/tui/fish
    ../../modules/tui/direnv
    ../../modules/tui/git
    ../../modules/tui/atuin
    ../../modules/tui/nushell
    ../../modules/tui/helix
  ];

  cli-tools.setting = {
    enable = true;
    monitoring = true;
    flex = true;
  };

  catppuccin = {
    zellij.enable = true;
    flavor = "mocha";
    mako.enable = false;
    helix.enable = false;
    starship.enable = false;
    atuin.enable = false;
  };
  # stylix.targets.qt.enable = false;
  # stylix.targets.gtk.enable = false;
  # qt = {
  #   style.name = "kvantum";
  #   platformTheme.name = "kvantum";
  # };

  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Catppuccin-Mocha-Standard-Mauve-Dark"; # Match what Stylix sets
  #     package = pkgs.catppuccin-gtk.override {
  #       accents = [ "mauve" ];
  #       variant = "mocha";
  #     };
  #   };
  #   iconTheme = {
  #     name = "Papirus-Dark";
  #     package = pkgs.papirus-icon-theme;
  #   };
  #   cursorTheme = {
  #     name = "Bibata-Modern-Ice";
  #     package = pkgs.bibata-cursors;
  #     size = 24;
  #   };
  # };

  home = {
    username = "${conf.user}";
    homeDirectory = "/home/${conf.user}";
    sessionVariables = {
      # Localization
      LC_ALL = "en_US.UTF-8";
      BROWSER = "zen";
      EDITOR = "nvim";
      SUDO_PROMPT = "Deploying root access for %u. Password pls: ";
    };
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/go/bin"
      "$HOME/.cargo/bin"
    ];
    packages = with pkgs; [
      kitty
      inputs.zen-browser.packages."${system}".default
      xclip
      lazygit
      # my NixVim configuration
      # inputs.Akari.packages.${system}.default
    ];
  };

  home.stateVersion = "25.05"; # Make sure to set this to your NixOS version
}
