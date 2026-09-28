{
  fetchurl,
  pkgs,
}:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "yt-dlp";
  version = "2026.08.19";

  src = fetchurl {
    url = "https://github.com/yt-dlp/yt-dlp/releases/download/${version}/yt-dlp_linux";
    hash = "sha256-WBYvm/3CdFjqR7/LMRz0cCjxfYFUqL99aJhh1GOZIwo=";
  };
  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    install -m755 $src $out/bin/yt-dlp
  '';
}
