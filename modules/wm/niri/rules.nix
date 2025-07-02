{ ... }:
let
  mkMatchRule =
    {
      appId,
      title ? "",
      openFloating ? false,
    }:
    let
      baseRule = {
        matches = [
          {
            app-id = appId;
            inherit title;
          }
        ];
      };
      floatingRule = if openFloating then { open-floating = true; } else { };
    in
    baseRule // floatingRule;

  openFloatingAppIds = [
    "^(pwvucontrol)"
    "^(Volume Control)"
    "^(dialog)"
    "^(file_progress)"
    "^(confirm)"
    "^(download)"
    "^(error)"
    "^(notification)"
    "^(spotify)"
    "^(hiddify)"
    "^(steam)"
    "^(com.mitchellh.ghostty)"
  ];

  floatingRules = builtins.map (
    appId:
    mkMatchRule {
      appId = appId;
      openFloating = true;
    }
  ) openFloatingAppIds;

  windowRules = [
    {
      geometry-corner-radius =
        let
          radius = 15.0;
        in
        {
          bottom-left = radius;
          bottom-right = radius;
          top-left = radius;
          top-right = radius;
        };
      clip-to-geometry = true;
      draw-border-with-background = false;
    }
    {
      matches = [ { app-id = "^niri$"; } ];
      opacity = 1.0;
    }
    {
      matches = [ { is-focused = false; } ];
      opacity = 0.95;
    }
    {
      matches = [
        { is-floating = true; }
      ];
      shadow.enable = true;
    }
    {
      matches = [
        {
          is-window-cast-target = true;
        }
      ];
      focus-ring = {
        active.color = "#f38ba8";
        inactive.color = "#a9b1d600 ";
      };

      border = {
        inactive.color = "#a9b1d600 ";
      };

      shadow = {
        color = "#f38ba800 ";
      };

      tab-indicator = {
        active.color = "#f38ba8";
        inactive.color = "#a9b1d600";
      };
    }
    {
      matches = [
        { app-id = "^(zen|firefox|equibop|chromium-browser|edge|chrome-.*|zen-.*)$"; }
      ];
      open-maximized = true;
    }
    {
      matches = [
        { app-id = "^(dropdown)$"; }
      ];
      open-floating = true;
      default-floating-position = {
        x = 0;
        y = 0;
        relative-to = "top";
      };
      default-window-height = {
        proportion = 0.5;
      };
      default-column-width = {
        proportion = 0.5;
      };
    }
  ];
in
{
  programs.niri.settings = {
    window-rules = windowRules ++ floatingRules;
  };
  programs.niri.settings.layer-rules = [
    {
      matches = [
        { namespace = "^swww-daemon$"; }
        { namespace = "^wallpaper$"; }
      ];

      place-within-backdrop = true;
    }
  ];
}
