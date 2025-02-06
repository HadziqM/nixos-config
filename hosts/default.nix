# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ../modules/nixos/fonts.nix
      ../modules/nixos/rust.nix
      ../modules/nixos/bootloader.nix
      ../modules/nixos/network.nix
      ../modules/nixos/users.nix
      ../modules/nixos/audio.nix
      inputs.home-manager.nixosModules.home-manager
    ];

	home-manager = {
		extraSpecialArgs = { inherit inputs;};

		users = {
			hadziq = import ./home-default.nix;
		};
	};

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Packages
  programs.firefox.enable = true;
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    # Flakes clones its dependencies through the git command,
    # so git must be installed first
    git
    vim
    wget
    curl
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-history-substring-search
  ];
  # Set the default editor to vim
  environment.variables.EDITOR = "vim";

  system.stateVersion = "24.11"; # Did you read the comment?
}
