{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      fira-sans
      roboto
      nerd-fonts._0xproto
      nerd-fonts.droid-sans-mono
      jetbrains-mono
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      material-symbols
      material-icons
    ];
    fontconfig.enable = true;
  };
}
