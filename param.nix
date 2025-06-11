let
  currentUser = builtins.getEnv "USER";
  user = if currentUser == "root" || currentUser == "" then "hadziq" else currentUser;
  efiSysMountPoint =
    if builtins.pathExists /boot/EFI then
      "/boot"
    else if builtins.pathExists /boot/efi/EFI then
      "/boot/efi"
    else
      null;
in
{
  inherit efiSysMountPoint user;
  useOSProber = false;
  # efiSysMountPoint = "/boot/efi";
  github = {
    email = "dimascrazz@gmail.com";
    username = "HadziqM";
  };
}
