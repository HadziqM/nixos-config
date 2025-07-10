{
  config,
  pkgs,
  ...
}:
let

  wall = pkgs.writeScriptBin "wall" (builtins.readFile ./wallPick.sh);
  waybarToggle = pkgs.writeScriptBin "wbar-toggle" (builtins.readFile ./waybarToggl.sh);
in
{
  programs.niri.settings.binds =
    with config.lib.niri.actions;
    let
      zellij = spawn "kitty" "-e" "zellij";
      yazi = spawn "kitty" "-e" "yazi";
      set-volume = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@";
      playerctl = spawn "${pkgs.playerctl}/bin/playerctl";
      wallPicker = spawn "${wall}/bin/wall";
      wbar = spawn "${waybarToggle}/bin/wbar-toggle";
      brightness-up = spawn "brightnessctl" "set" "10%+";
      brightness-down = spawn "brightnessctl" "set" "10%-";
    in
    {
      "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
      "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";

      "XF86AudioPlay".action = playerctl "play-pause";
      "XF86AudioStop".action = playerctl "pause";
      "XF86AudioPrev".action = playerctl "previous";
      "XF86AudioNext".action = playerctl "next";

      "XF86AudioRaiseVolume".action = set-volume "5%+";
      "XF86AudioLowerVolume".action = set-volume "5%-";

      "XF86MonBrightnessUp".action = brightness-up;
      "XF86MonBrightnessDown".action = brightness-down;

      "Print".action.screenshot-screen = {
        write-to-disk = true;
      };
      "Mod+V".action = toggle-overview;
      "Mod+Shift+Alt+S".action = screenshot-window;
      "Mod+Shift+S".action = screenshot;
      "Mod+Return".action = spawn "kitty";
      "Alt+Z".action = zellij;
      "Alt+B".action = spawn "zen";
      "Alt+D".action = spawn "vesktop";
      "Alt+M".action = spawn "spotify";
      "Alt+Y".action = yazi;
      "Mod+G".action = maximize-column;
      "Alt+Space".action = spawn "wofi" "--show" "drun";
      "Ctrl+Alt+L".action = spawn "hyprlock";
      "Mod+Alt+Q".action = spawn "wlogout";
      "Mod+E".action = wallPicker;
      "Mod+W".action = wbar;
      "Mod+Q".action = close-window;
      "Mod+S".action = switch-preset-column-width;
      "Mod+F".action = fullscreen-window;
      "Mod+Shift+Space".action = fullscreen-window;
      "Mod+Shift+F".action = expand-column-to-available-width;
      "Mod+Space".action = toggle-window-floating;
      "Mod+T".action = toggle-column-tabbed-display;
      "Mod+Comma".action = consume-window-into-column;
      "Mod+Period".action = expel-window-from-column;
      "Mod+C".action = center-window;
      "Mod+Tab".action = switch-focus-between-floating-and-tiling;

      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;
      "Mod+6".action = focus-workspace 6;
      "Mod+7".action = focus-workspace 7;
      "Mod+8".action = focus-workspace 8;
      "Mod+9".action = focus-workspace 9;
      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";
      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";

      "Mod+H".action = focus-column-left;
      "Mod+L".action = focus-column-right;
      "Mod+J".action = focus-window-or-workspace-down;
      "Mod+K".action = focus-window-or-workspace-up;
      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Down".action = focus-workspace-down;
      "Mod+Up".action = focus-workspace-up;

      "Mod+Shift+H".action = move-column-left;
      "Mod+Shift+L".action = move-column-right;
      "Mod+Shift+K".action = move-column-to-workspace-up;
      "Mod+Shift+J".action = move-column-to-workspace-down;

      "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
      "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
    };
}
