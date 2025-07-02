{ inputs, pkgs, ... }:
{
  imports = [
    inputs.niri.homeModules.niri
    ./settings.nix
    ./binds.nix
    ./waybar.nix
    ./rules.nix
    ./wlogout.nix
  ];
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    gnome-keyring
  ];
  home = {
    packages = with pkgs; [
      gnome-keyring
      wl-clipboard
      qt6.qtwayland
      wl-clip-persist
      cliphist
      xwayland-satellite
      wl-clipboard
      catppuccin-cursors.mochaGreen
      libnotify
      mako
    ];
  };
  stylix.targets.mako.enable = false;
  services.swww.enable = true;
  services.mako = {
    enable = true;
    settings = {
      # Applies to notifications that are actionable (e.g., have buttons)
      "actionable=true" = {
        anchor = "top-left";
      };

      # Global settings
      actions = true;
      anchor = "top-right";
      background-color = "#00000080"; # semi-transparent black
      border-color = "#FFFFFF";
      border-radius = 8;
      default-timeout = 5000; # 5 seconds in milliseconds
      font = "monospace 10";
      height = 100;
      icons = true;
      ignore-timeout = false;
      layer = "top";
      margin = 10;
      markup = true;
      width = 300;
    };

  };
  home.file = {
    ".config/wofi/walpaper.conf".source = ./walpaper.conf;
    ".config/wofi/walpaper.css".source = ./wofi.css;
  };
  programs.wofi = {
    enable = true;
    settings = {
      mode = "drun";
      allow_images = true;
    };
    style = builtins.readFile ./wofi.css;
  };
  systemd.user.services.wayland-satalite = {
    Unit = {
      Description = "Xwayland Satalite Service";
      After = " config.wayland.systemd.target";
      PartOf = " config.wayland.systemd.target";
    };
    Install.WantedBy = [ "config.wayland.systemd.target " ];
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
      Restart = "on-failure";
      Environment = [
        "WAYLAND_DISPLAY=wayland-1"
        "XDG_RUNTIME_DIR=/run/user/%U"
      ];
    };
  };
}
