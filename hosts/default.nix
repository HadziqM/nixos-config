{
  pkgs,
  conf,
  inputs,
  ...
}:
{

  imports = [
    # Include the results of the hardware scan.
    ../modules/nixos/essentials
    ../modules/nixos/network
    ../modules/nixos/game
    ../modules/nixos/podman.nix
    ../modules/nixos/flatpak.nix
    # ../modules/nixos/rust.nix
    # ../modules/wm/gnome
    ../modules/wm/sddm
    ../modules/wm/stylix
  ];

  programs.niri.enable = true;

  users.users.${conf.user} = {
    isNormalUser = true;
    description = "main user";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
    ];
    shell = pkgs.nushell;
  };

  nix.settings.trusted-users = [
    "root"
    conf.user
  ];
  documentation.man.generateCaches = false;

  # Enable CUPS to print documents.
  services = {
    displayManager = {
      autoLogin = {
        enable = false;
        inherit (conf) user;
      };
      defaultSession = "niri";
    };
    cron = {
      enable = true;
    };
    libinput.enable = true;
    fstrim.enable = true;
    openssh.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    printing = {
      enable = true;
      drivers = [ pkgs.hplipWithPlugin ];
    };
    power-profiles-daemon.enable = true;
    thermald.enable = true;
    gnome.gnome-keyring.enable = true;
    gnome.gcr-ssh-agent.enable = true;
  };

  programs = {
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };
    firefox.enable = false;
    dconf.enable = true;
    fuse.userAllowOther = true;
    zsh.enable = true;
    fish.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
      ];
    };
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = with pkgs; [

    inputs.quickshell.packages.${system}.default
    inputs.matugen.packages.${system}.default
    # Flakes clones its dependencies through the git command,
    # so git must be installed first
    vim
    curl
    nano

    nodejs
    clang
    llvmPackages.bintools
    rustup
    gcc
    gnumake

    bibata-cursors

    openssl

    # Version control and development tools
    git
    gh
    coreutils

    # Shell and terminal utilities
    stow
    wget
    killall
    kitty
    fzf
    tmux
    progress
    exfatprogs

    # File management and archives
    p7zip
    unzip
    unrar
    xarchiver

    #Icon Theme
    sweet-folders

    # System monitoring and management
    htop
    btop

    # Network and internet tools
    aria2
    qbittorrent

    # Audio and video
    pulseaudio
    pavucontrol
    mpv

    # Image and graphics
    imagemagick
    imv

    # System utilities
    libgcc
    bc
    lxqt.lxqt-policykit
    libnotify
    v4l-utils
    ydotool
    pciutils
    ripgrep
    lshw
    bat
    pkg-config

    brightnessctl
    ddcutil

    swappy
    appimage-run
    yad
    playerctl
    nh

    # File systems
    ntfs3g
    os-prober

    # Downloaders
    localsend

    # Clipboard managers
    cliphist

    # Fun and customization
    fastfetch
    microfetch

    # Networking
    networkmanagerapplet
    dig
    distrobox
    gpsd
    niri

    gparted
  ];
  # Set the default editor to vim
  environment.variables.EDITOR = "vim";

  system.stateVersion = "25.05"; # Did you read the comment?
}
