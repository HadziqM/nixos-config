{ pkgs, ... }:

let
  nier-automata-sddm = pkgs.stdenvNoCC.mkDerivation {
    pname = "sddm-theme-nier-automata";
    version = "1.0";

    src = ../../../asset/themes-nier-automata;

    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/sddm/themes/nier-automata
      cp -r ./* $out/share/sddm/themes/nier-automata/

      runHook postInstall
    '';
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;

    theme = "nier-automata";

    package = pkgs.kdePackages.sddm;

    extraPackages = [
      nier-automata-sddm
      pkgs.kdePackages.qt5compat
      pkgs.kdePackages.qtmultimedia
      pkgs.kdePackages.qtsvg
    ];
  };

  environment.systemPackages = [
    nier-automata-sddm
    pkgs.kdePackages.qtmultimedia
  ];
}
