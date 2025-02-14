{ pkgs, ... }: {
  networking.wg-quick.interfaces = let
    server_ip = "103.150.190.20";
  in {
    wg0 = {
      # IP address of this machine in the *tunnel network*
      address = [
        "10.0.0.4/32"
      ];

      listenPort = 51820;

      # Path to the private key file.
      privateKeyFile = "/etc/wg0.key";

      peers = [{
        publicKey = "9rvqcdaEhV9GGWRLJsCBBcIqJd4AGM58dsJSb5rKnQY=";
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = "${server_ip}:51820";
        persistentKeepalive = 25;
      }];
    };
  };
}
