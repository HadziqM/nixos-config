# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, options,  ... }:

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
      ../modules/nixos/gnome.nix
      ../modules/nixos/hyprland.nix
      ../modules/nixos/hyprland.nix
      ../modules/nixos/mimetype.nix
      ../modules/nixos/gpu-driver/amd-drivers.nix
      inputs.home-manager.nixosModules.home-manager
    ];

	home-manager = {
		extraSpecialArgs = { inherit inputs;};

		users = {
			hadziq = import ./home-default.nix;
		};
	};
  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Packages
  programs = {
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };
    firefox.enable = false;
    dconf.enable = true;
    fuse.userAllowOther = true;
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

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
    openssl
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-history-substring-search

    # Zen Browser from custom input
    inputs.zen-browser.packages."${system}".default


    # File management and archives
    yazi
    p7zip
    unzip
    unrar
    file-roller
    ncdu
    duf


    # System monitoring and management
    htop
    btop
    lm_sensors
    inxi

    # Network and internet tools
    aria2
    qbittorrent
    cloudflare-warp
    tailscale


    # Audio and video
    pulseaudio
    pavucontrol
    ffmpeg
    mpv
    deadbeef-with-plugins

    # Image and graphics
    imagemagick
    gimp
    hyprpicker
    swww
    hyprlock
    waypaper
    imv


    # Productivity and office
    obsidian
    onlyoffice-bin


    # System utilities
    libgcc
    bc
    kdePackages.dolphin
    lxqt.lxqt-policykit
    libnotify
    v4l-utils
    ydotool
    pciutils
    socat
    cowsay
    ripgrep
    lshw
    bat
    pkg-config
    brightnessctl
    virt-viewer
    swappy
    appimage-run
    yad
    playerctl
    nh
    ansible


    # File systems
    ntfs3g
    os-prober

    # Downloaders
    yt-dlp
    localsend

    # Clipboard managers
    cliphist

    # Fun and customization
    cmatrix
    lolcat
    fastfetch
    onefetch
    microfetch

    # Networking
    networkmanagerapplet

    # Education
    # ciscoPacketTracer8
    wireshark
    ventoy


    # Miscellaneous
    greetd.tuigreet
  ];
  # Set the default editor to vim
  environment.variables.EDITOR = "vim";

  system.stateVersion = "24.11"; # Did you read the comment?
}
