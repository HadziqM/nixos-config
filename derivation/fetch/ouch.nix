{ pkgs, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "ouch";
  version = "0.8.3";

  src = pkgs.fetchurl {
    url = "https://github.com/ouch-org/ouch/releases/download/${version}/ouch-x86_64-unknown-linux-gnu.tar.gz";
    hash = "sha256-8GZMuzv4xceBY32iyLuGtFYahwn34Q3bEYgVDmjmGac=";
  };

  nativeBuildInputs = [
    pkgs.autoPatchelfHook
    pkgs.installShellFiles
  ];

  sourceRoot = "ouch-x86_64-unknown-linux-gnu";

  buildInputs = [
    pkgs.stdenv.cc.cc.lib
  ];

  installPhase = ''
    runHook preInstall

    # Install main binary
    install -Dm755 ouch -t $out/bin/

    # Install completions
    installShellCompletion --bash completions/ouch.bash
    installShellCompletion --fish completions/ouch.fish
    installShellCompletion --zsh completions/_ouch

    # Install man pages
    installManPage man/*

    runHook postInstall
  '';
}
