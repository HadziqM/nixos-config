{ inputs, pkgs, ... }:
let
  buildInputs = with pkgs; [
    openssl
    libiconv
    glib
    gtk3
    libsoup_3
    webkitgtk_4_1
    xdotool
    gcc
  ];
  toolchain = pkgs.rust-bin.nightly.latest.default.override {
    targets = [
      "wasm32-unknown-unknown"
      "aarch64-linux-android"
      "armv7-linux-androideabi"
      "i686-linux-android"
      "x86_64-linux-android"
    ];
  };

  rust-tools = with pkgs; [
    sqlx-cli
    dioxus-cli
    wasm-bindgen-cli
  ];
in
{

  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];

  home.packages =
    buildInputs
    ++ rust-tools
    ++ [
      toolchain
    ];
}
