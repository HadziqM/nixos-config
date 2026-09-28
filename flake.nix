{
  description = "A simple NixOS flake";

  nixConfig = {
    substituters = [
      # "http://192.168.1.14:5000"
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
      "https://noctalia.cachix.org"
      "https://focal.cachix.org"
    ];
    trusted-public-keys = [
      # "binarycache.example.com:DGyPKTV70YTe4OBNTEhO8puBf6jNGuswWXD1SerbMY4="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "focal.cachix.org-1:/YkOWkXNH2uK7TnskrVMvda8LyCe4iIbMM1sZN2AOXY="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
    };

  };

  outputs =
    {
      nixpkgs,
      rust-overlay,
      hjem,
      ...
    }@inputs:
    let
      conf = import ./param.nix;
      overlays = [
        (import rust-overlay)
        inputs.niri.overlays.niri
      ];
      pkgs = import nixpkgs {
        inherit overlays;
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
          android_sdk.accept_license = true;
        };
      };
      system = pkgs.stdenv.hostPlatform.system;

      mkNixosSystem =
        configPath:
        nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = { inherit inputs conf; };
          modules = [
            configPath
            hjem.nixosModules.default
            {
              hjem = {
                extraModules = [
                  inputs.noctalia.hjemModules.default
                ];
                specialArgs = { inherit inputs conf; };
                users.${conf.user} = import ./home/hadziq/hjem.nix;
                linker = null;
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        default = mkNixosSystem ./hosts/laptop/configuration.nix;
        hadziq-pc = mkNixosSystem ./hosts/pc/configuration.nix;
        hadziq-laptop = mkNixosSystem ./hosts/laptop/configuration.nix;
      };
    };
}
