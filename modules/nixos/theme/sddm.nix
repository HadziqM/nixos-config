{ pkgs, lib, ... }:
# let
#   background-package = pkgs.stdenvNoCC.mkDerivation {
#     name = "background-image";
#     src = ../../../neon.jpg;
#     dontUnpack = true;
#     installPhase = ''
#       cp $src $out
#     '';
#   };
# in
{

  #services.xserver.enable = true;
  services.displayManager.sddm = {
    theme = "sddm-astronaut-theme";
  };

  environment.systemPackages = [
    pkgs.sddm-astronaut
    (pkgs.writeTextDir "share/sddm/themes/sddm-astronaut-theme/metadata.desktop" ''
      [SddmGreeterTheme]
      Name=sddm-astronaut-theme
      Description=sddm-astronaut-theme
      Author=keyitdev
      Website=https://github.com/Keyitdev/sddm-astronaut-theme
      License=GPL-3.0-or-later
      Type=sddm-theme
      Version=1.3
      ConfigFile=Themes/pixel_sakura.conf
      Screenshot=Previews/astronaut.png
      MainScript=Main.qml
      TranslationsDirectory=translations
      Theme-Id=sddm-astronaut-theme
      Theme-API=2.0
      QtVersion=6

    '')
  ];
}
