# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, options, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
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
      ../modules/nixos/wireguard.nix
      ../modules/nixos/gpu-driver/amd-drivers.nix
      inputs.home-manager.nixosModules.default
    ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };

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

  stylix = {
    enable = true;
    image = ../config/assets/wall.png;
    base16Scheme = {
      base00 = "191724";
      base01 = "1f1d2e";
      base02 = "26233a";
      base03 = "6e6a86";
      base04 = "908caa";
      base05 = "e0def4";
      base06 = "e0def4";
      base07 = "524f67";
      base08 = "eb6f92";
      base09 = "f6c177";
      base0A = "ebbcba";
      base0B = "31748f";
      base0C = "9ccfd8";
      base0D = "c4a7e7";
      base0E = "f6c177";
      base0F = "524f67";
    };
    polarity = "dark";
    opacity.terminal = 0.8;
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 24;
    targets.qt.platform = lib.mkForce "qtct";
    fonts = {
      monospace = {
        package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 11;
        popups = 12;
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    # Flakes clones its dependencies through the git command,
    # so git must be installed first
    vim
    curl
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-history-substring-search


    # Text editors and IDEs
    nano
    vscode
    zed-editor
    jetbrains.idea-ultimate

    # Programming languages and tools
    lua
    python3
    python3Packages.pip
    clang
    nodePackages_latest.yarn
    gcc
    openssl

    # Frappe Bench
    redis

    # Version control and development tools
    git
    gh
    lazygit
    bruno
    postman
    bruno-cli
    gnumake
    coreutils
    nixfmt-rfc-style
    meson
    ninja

    # Shell and terminal utilities
    stow
    wget
    killall
    eza
    starship
    kitty
    zoxide
    fzf
    tmux
    progress
    tree
    exfatprogs

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
