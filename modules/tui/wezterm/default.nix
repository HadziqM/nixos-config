{
  pkgs,
  ...
}:
{
  files.".config/wezterm/wezterm.lua".source = ./wezterm.lua;

  packages = with pkgs; [
    wezterm
  ];
}
