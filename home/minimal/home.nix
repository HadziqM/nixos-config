{
  pkgs,
  inputs,
  conf,
  ...
}:
{

  imports = [
    ../../dotfiles

    ../../modules/tui/cli-tools
    ../../modules/tui/starship
    ../../modules/tui/fish
    ../../modules/tui/direnv
    ../../modules/tui/git
    ../../modules/tui/atuin
  ];

  cli-tools.setting = {
    enable = true;
    # monitoring = true;
    # flex = true;
  };

  home = {
    username = "${conf.user}";
    homeDirectory = "/home/${conf.user}";
    sessionVariables = {
      # Localization
      LC_ALL = "en_US.UTF-8";
      EDITOR = "vim";
      SUDO_PROMPT = "Deploying root access for %u. Password pls: ";
    };
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/go/bin"
      "$HOME/.cargo/bin"
    ];
    packages = with pkgs; [
      xclip
      lazygit
    ];
  };

  home.stateVersion = "25.05"; # Make sure to set this to your NixOS version
}
