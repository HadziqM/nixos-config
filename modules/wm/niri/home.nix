{ pkgs, ... }:
{
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
  home.sessionVariables = {
    # QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_STYLE_OVERRIDE = "kvantum";
    XDG_SESSION_TYPE = "wayland";
  };
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    gnome-keyring
  ];
}
