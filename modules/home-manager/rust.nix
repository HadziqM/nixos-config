{ inputs, pkgs, ... }:

{

  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];

  home.packages = with pkgs; [
    (rust-bin.nightly.latest.default.override {
      targets = [
        "wasm32-unknown-unknown"
        "aarch64-linux-android"
        "armv7-linux-androideabi"
        "i686-linux-android"
        "x86_64-linux-android"
      ];
    })
    gcc
    sqlx-cli
    dioxus-cli
    wasm-bindgen-cli
    trunk
  ];
}
