{ lib, config, pkgs, ... }:

{
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking = {
    resolvconf.enable = false;
    hostName = "nixos";
    nameservers = [ "1.1.1.1" "8.8.8.8" "9.9.9.9" ]; # Cloudflare, Google, Quad9
    dhcpcd.extraConfig = ''
      nohook resolv.conf
    '';
    networkmanager = {
      insertNameservers = [ "1.1.1.1" "8.8.8.8" "9.9.9.9" ];
      enable = true;
    };
  };

  services.resolved = {
    enable = true;
    dnssec = "true";  # Enable DNSSEC for security
    domains = [ "~." ];  # Ensure the DNS applies globally
    extraConfig = ''
      DNSOverHTTPS=true
      DNSOverHTTPSServers=cloudflare-dns.com
    '';
  };

  services.dnscrypt-proxy2.enable = true;
  services.dnscrypt-proxy2.settings = {
    server_names = [ "cloudflare" ];
  };


  networking.firewall.allowedTCPPorts = [ 9050 22 ];
  networking.firewall.allowedUDPPorts = [ 9050 ];

  services.openssh.enable = true;

  services.tor.enable = true;
  services.tor.client.enable = true;
  # services.tor.client.extraConfig = ''
  #   SocksPort 9050
  #   Log notice file /var/log/tor/notices.log
  # '';

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
}
