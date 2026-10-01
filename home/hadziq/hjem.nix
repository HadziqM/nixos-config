{
  # pkgs,
  conf,
  ...
}:
{

  imports = [
    ../../modules/gui/apps

    ../../modules/tui/cli-tools
    ../../modules/tui/zsh
    ../../modules/tui/git
    ../../modules/tui/wezterm
    ../../modules/tui/zellij
    ../../modules/tui/helix
    ../../modules/tui/yazi

    ../../modules/wm/niri
    ../../modules/wm/noctalia.nix
  ];

  cli-tools.setting = {
    enable = true;
    monitoring = true;
    flex = true;
  };

  xdg.mime-apps = {
    default-applications = {
      "inode/directory" = "yazi-term.desktop";
      "text/plain" = "hx.desktop";
      "application/x-directory" = "yazi-term.desktop";
    };
  };
  clobberFiles = true;

  user = "${conf.user}";
  directory = "/home/${conf.user}";
  environment.sessionVariables = {
    # Localization
    LC_ALL = "en_US.UTF-8";
    BROWSER = "zen";
    EDITOR = "hx";
    TERMINAL = "wezterm";
    SUDO_PROMPT = "Deploying root access for %u. Password pls: ";
    PATH = [
      "$HOME/.local/bin"
      "$HOME/go/bin"
      "$HOME/.cargo/bin"
    ];
  };

}
