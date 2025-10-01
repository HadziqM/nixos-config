{ pkgs, lib, ... }:

let
  # Define the Noctalia shell package
  # noctalia-shell = pkgs.stdenv.mkDerivation {
  #   pname = "noctalia-shell";
  #   version = "latest";

  #   src = pkgs.fetchurl {
  #     url = "https://github.com/noctalia-dev/noctalia-shell/releases/latest/download/noctalia-latest.tar.gz";
  #     sha256 = "sha256-2PCcRtTvkROn99SFLRe7Vz2HQacnMwj5U+Eu6dGF6sw=";
  #   };

  #   installPhase = ''
  #     mkdir -p $out
  #     cp -r * $out/
  #   '';

  # };

  wallpaperRepo = pkgs.fetchFromGitHub {
    owner = "DenverCoder1";
    repo = "minimalistic-wallpaper-collection";
    rev = "main";
    sha256 = "sha256-x0Ho/KUbQBvpEsxNpNSS2t/tWbZHlA9tQQO24B9Wqfc=";
  };
in
{
  # home.file.".config/quickshell" = {
  #   source = noctalia-shell;
  #   recursive = true;
  # };

  home.activation.myScript = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p "$HOME/.config/noctalia/"
    $DRY_RUN_CMD cp -f ${../../../asset/icon.png} "$HOME/.face"
    $DRY_RUN_CMD cp -n ${../../../asset/settings.json} "$HOME/.config/noctalia/"
    $DRY_RUN_CMD cp -rn ${wallpaperRepo}/images/* "$HOME/Pictures/wallpapers/"
  '';
}
