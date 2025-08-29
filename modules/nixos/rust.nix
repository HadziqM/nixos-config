{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];

  environment.systemPackages = with pkgs; [
    (rust-bin.nightly.latest.default.override {
      targets = [
        "wasm32-unknown-unknown"
        "aarch64-linux-android"
        "armv7-linux-androideabi"
        "i686-linux-android"
        "x86_64-linux-android"
      ];

      extensions = [
        "rust-src"
        "clippy"
        "rustfmt"
        "rust-analyzer"
      ];
    })
    gcc
    sqlx-cli
    dioxus-cli
    wasm-bindgen-cli
    trunk
    cargo-deb
    cargo-bundle
    cargo-cache
    cargo-watch
  ];
}
