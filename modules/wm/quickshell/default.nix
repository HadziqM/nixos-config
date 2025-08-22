{ pkgs, lib, ... }:

let
  # Define the Noctalia shell package
  noctalia-shell = pkgs.stdenv.mkDerivation rec {
    pname = "noctalia-shell";
    version = "latest";

    src = pkgs.fetchurl {
      url = "https://github.com/noctalia-dev/noctalia-shell/releases/latest/download/noctalia-latest.tar.gz";
      # You'll need to get the actual hash by running:
      # nix-prefetch-url https://github.com/noctalia-dev/noctalia-shell/releases/latest/download/noctalia-latest.tar.gz
      sha256 = "sha256-UagJGeyXRF0CNDqnd290IQ/Tdrac5qGwXma6jtcjZzM="; # Replace with actual hash
    };

    installPhase = ''
      mkdir -p $out
      cp -r * $out/
    '';

    meta = with lib; {
      description = "Noctalia Shell - A quickshell configuration";
      homepage = "https://github.com/noctalia-dev/noctalia-shell";
      platforms = platforms.linux;
    };
  };
in
{
  # Option 1: Using home.file to place files directly
  home.file.".config/quickshell" = {
    source = noctalia-shell;
    recursive = true;
  };
}
