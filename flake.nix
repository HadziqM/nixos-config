{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    jovian.follows = "chaotic/jovian";
    rust-overlay.url = "github:oxalica/rust-overlay";

    flake-utils.url = "github:numtide/flake-utils";

    stylix.url = "github:danth/stylix";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My Neovim config, now i use helix
    # Akari.url = "github:HadziqM/Akari";

    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    matugen = {
      url = "github:/InioX/Matugen";
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      rust-overlay,
      chaotic,
      jovian,
      distro-grub-themes,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      conf = import ./param.nix;
      overlays = [
        (import rust-overlay)
        inputs.niri.overlays.niri
      ];
      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };

      mkHomeManager =
        modules:
        home-manager.lib.homeManagerConfiguration {
          inherit system pkgs modules;
          specialArgs = { inherit inputs conf; };
        };

      mkNixosSystem =
        configPath:
        nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = { inherit inputs conf; };
          modules = [
            configPath
            chaotic.nixosModules.default
            jovian.nixosModules.default
            stylix.nixosModules.stylix
            distro-grub-themes.nixosModules.${system}.default
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                # make global and home manager use same nixpkgs
                useGlobalPkgs = true;
                # instead `$HOME/.nix-profile` use `/etc/profiles` instead
                # so its possible to install sudo application
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs conf; };
                users.${conf.user} = import ./home/hadziq/home.nix;
              };
            }
          ];
        };
    in
    {
      homeConfigurations = {
        minimal = mkHomeManager [ ./home/minimal/home.nix ];
        full = mkHomeManager [ ./home/hadziq/home.nix ];
      };
      nixosConfigurations = {
        default = mkNixosSystem ./hosts/laptop/configuration.nix;
        hadziq-pc = mkNixosSystem ./hosts/pc/configuration.nix;
        hadziq-laptop = mkNixosSystem ./hosts/laptop/configuration.nix;
      };
    };
}
