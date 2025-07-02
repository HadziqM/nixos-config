{ pkgs, ... }:
let
  background-package = pkgs.stdenvNoCC.mkDerivation {
    name = "background-image";
    src = ../../../neon.jpg;
    dontUnpack = true;
    installPhase = ''
      cp $src $out
    '';
  };
  astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "cyberpunk";
    themeConfig = {
      Background = "${background-package}";
    };
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    package = pkgs.kdePackages.sddm;
    extraPackages = [ pkgs.sddm-astronaut ];
  };

  environment.systemPackages = [
    pkgs.sddm-astronaut
    pkgs.kdePackages.qtmultimedia
  ];
}
