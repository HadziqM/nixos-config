# {
#   lib,
#   inputs,
#   pkgs,
#   ...
# }:
# let
#   grub-theme = "apple-grub-theme";
#   system = pkgs.stdenv.hostPlatform.system;
# in
# {
#   boot.loader.grub = {
#     theme = lib.mkForce inputs.distro-grub-themes.packages.${system}.${grub-theme};
#     splashImage = lib.mkForce "${
#       inputs.distro-grub-themes.packages.${system}.${grub-theme}
#     }/splash_image.jpg";
#   };
# }
{ pkgs, ... }:

let
  seeleGrubTheme = pkgs.stdenvNoCC.mkDerivation {
    pname = "grub-theme-seele";
    version = "1.0";

    src = ../../../asset/themes-seele-grub;

    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out
      cp -r ./* $out/

      runHook postInstall
    '';
  };
in
{
  boot.loader.grub = {
    enable = true;
    theme = seeleGrubTheme;
  };
}
