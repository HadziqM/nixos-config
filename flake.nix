{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";

    flake-utils.url  = "github:numtide/flake-utils";

        # stylix: A theming framework for NixOS
    stylix.url = "github:danth/stylix";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

  };

  outputs = { self, nixpkgs, ... }@inputs: let
    system = "x86_64-linxu";
  in {
    # Please replace my-nixos with your hostname
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./hosts/default.nix
        ({
          config,
          pkgs,
          ...
        }: {
          # Enable unfree packages globally
          nixpkgs.config.allowUnfree = true;

          # Configure the hyprpanel overlay
          nixpkgs.overlays = [
            hyprpanel.overlay
          ];
        })

        # Stylix module for system-wide theming
        inputs.stylix.nixosModules.stylix

        # Home-manager module for user environment management
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
