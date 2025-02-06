{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];

  # change this to stable if wanted to
  environment.systemPackages = [ 
    (pkgs.rust-bin.nightly.latest.default.override {
      targets = [ "wasm32-unknown-unknown" ];
      extensions = [ "rust-src" ];  # Optional: Needed for some tooling
    })
  ];

}

