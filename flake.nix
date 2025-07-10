{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";

    flake-utils.url = "github:numtide/flake-utils";

    # stylix: A theming framework for NixOS
    stylix.url = "github:danth/stylix";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    Akari.url = "github:HadziqM/Akari";

    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      rust-overlay,
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
    in
    {
      homeConfigurations = import ./home {
        inherit home-manager pkgs;
        extraSpecialArgs = { inherit inputs conf; };
      };
      # Please replace my-nixos with your hostname
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = { inherit inputs conf; };
          modules = [
            ./hosts/laptop/configuration.nix
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

        hadziq-pc = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = { inherit inputs conf; };
          modules = [
            ./hosts/pc/configuration.nix
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

        hadziq-laptop = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = { inherit inputs conf; };
          modules = [
            ./hosts/laptop/configuration.nix
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

      };
    };
}
