{
  networking = {
    hostName = "nixos";
    nameservers = [
      "127.0.0.1"
      "1.1.1.1"
      "8.8.8.8"
      "9.9.9.9"
    ]; # Cloudflare, Google, Quad9
    dhcpcd.extraConfig = "nohook resolv.conf";
    # If using NetworkManager:
    networkmanager = {
      enable = true;
      dns = "none";
    };
  };

  time.timeZone = "Asia/Jakarta";

  i18n.defaultLocale = "en_US.UTF-8";

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  networking.firewall.enable = false;

}
