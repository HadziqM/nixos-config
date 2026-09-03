{
  fetchurl,
  pkgs,
}:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "yt-dlp";
  version = "2026.06.09";

  src = fetchurl {
    url = "https://github.com/yt-dlp/yt-dlp/releases/download/${version}/yt-dlp_linux";
    hash = "sha256-wrAYn1gf5KLd1BlU8by30yfbBLB+0N6pfk8bPgm13Y4=";
  };
  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    install -m755 $src $out/bin/yt-dlp
  '';
}
