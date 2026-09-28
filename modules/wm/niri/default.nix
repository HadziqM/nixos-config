{
  pkgs,
  ...
}:
let
  conf = pkgs.replaceVars ./config.kdl {
    pantheon-polkit = toString pkgs.pantheon.pantheon-agent-polkit;
  };
in
{
  files.".config/niri/config.kdl".source = conf;

  packages = with pkgs; [
    xclip
    wl-clipboard
    wl-clip-persist
    cliphist
    playerctl
    brightnessctl
    libnotify
    pantheon.pantheon-agent-polkit
    xwayland-satellite
    lazygit
    direnv
    nix-direnv
    lyra-cursors
  ];
}
