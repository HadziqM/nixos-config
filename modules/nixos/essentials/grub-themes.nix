{
  lib,
  inputs,
  pkgs,
  ...
}:
let
  grub-theme = "apple-grub-theme";
  system = pkgs.stdenv.hostPlatform.system;
in
{
  boot.loader.grub = {
    theme = lib.mkForce inputs.distro-grub-themes.packages.${system}.${grub-theme};
    splashImage = lib.mkForce "${
      inputs.distro-grub-themes.packages.${system}.${grub-theme}
    }/splash_image.jpg";
  };
}
