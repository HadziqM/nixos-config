{
  config,
  pkgs,
  lib,
  ...
}:

{
  stylix.targets.vencord.enable = false;
  stylix.targets.vesktop.enable = false;

  programs.vesktop = {
    enable = true;

    settings = {
      appBadge = false;
      arRPC = true;
      customTitleBar = false;
      hardwareAcceleration = true;
      discordBranch = "stable";
      minimizeToTray = true;
      tray = true;
    };

    vencord = {
      themes = {
        "translucence" = ./themes/translucence.css;
        "frostedGlass" = ./themes/FrostedGlass.theme.css;
      };

      settings = {
        enabledThemes = [
          "frostedGlass.css"
        ];
      };
    };
  };
}
