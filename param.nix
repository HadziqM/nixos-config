let
  hostName = builtins.getEnv "HOST";
in
{
  user = "hadziq";

  efiSysMountPoint = if hostName == "hadziq-laptop" then "/boot" else "/boot/efi";

  useOSProber = false;
  github = {
    email = "dimascrazz@gmail.com";
    username = "HadziqM";
  };
}
