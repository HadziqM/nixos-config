{
  stylix.targets.waybar.enable = false;
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./waybarr.css;
    settings = [

      {
        layer = "top";
        position = "top";
        height = 24;
        spacing = 5;

        modules-left = [
          "niri/workspaces"
          "temperature"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "wireplumber"
          "battery"
          "idle_inhibitor"
          "network"
          "bluetooth"
          "tray"
        ];

        "niri/workspaces" = {
          format = "<span size='larger'>{icon}</span>";
          on-click = "activate";
          format-icons = {
            active = "";
            default = "";
          };
          icon-size = 10;
          sort-by-number = true;
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
          };
        };

        clock = {
          format = "{:%d.%m.%Y | %H:%M}";
        };

        wireplumber = {
          format = " {volume}%";
          max-volume = 100;
          scroll-step = 5;
        };

        battery = {
          bat = "BAT1";
          interval = 60;
          format = "{icon} {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        memory = {
          interval = 30;
          format = " {used:0.1f}G";
        };

        temperature = {
          format = "{temperatureC}°C";
        };

        network = {
          format = "";
          format-ethernet = "";
          format-wifi = "";
          format-disconnected = "";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-ethernet = "{ifname}";
          tooltip-format-disconnected = "Disconnected";
        };

        bluetooth = {
          format = "";
          format-disabled = "";
          format-connected = "";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        };

        tray = {
          icon-size = 16;
          spacing = 16;
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
      }

    ];
  };
}
