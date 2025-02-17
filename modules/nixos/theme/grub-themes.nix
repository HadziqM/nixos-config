{
  lib,
  inputs,
  ...
}:
let
  system = "x86_64-linux";
  grub-theme = "apple-grub-theme";
in
{
  boot.loader.grub = {
    theme = lib.mkForce inputs.distro-grub-themes.packages.${system}.${grub-theme};
    splashImage = lib.mkForce "${
      inputs.distro-grub-themes.packages.${system}.${grub-theme}
    }/splash_image.jpg";
  };
}
