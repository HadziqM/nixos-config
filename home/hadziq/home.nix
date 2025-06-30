{
  pkgs,
  inputs,
  conf,
  ...
}:
{

  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    ../../dotfiles

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
      inputs.Akari.packages.${system}.default
    ];
  };

  home.stateVersion = "25.05"; # Make sure to set this to your NixOS version
}
