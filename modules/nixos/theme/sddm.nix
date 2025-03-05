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
    theme = "sddm-astronaut-theme";
    package = pkgs.kdePackages.sddm;
    extraPackages = [ astronaut ];
  };

  environment.systemPackages = [
    astronaut
    pkgs.kdePackages.qtmultimedia
  ];
}
