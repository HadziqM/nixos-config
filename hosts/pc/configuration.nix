{
  inputs,
  pkgs,
  conf,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nixos/essentials
    ../../modules/nixos/network
    ../../modules/nixos/game
    ../../modules/nixos/gpu-driver/amd-drivers.nix
    ../../modules/nixos/podman.nix
    ../../modules/nixos/flatpak.nix
    ../../modules/wm/gnome
    ../../modules/wm/sddm
    ../../modules/wm/stylix
  ];

  networking.hostName = "hadziq-pc";

  users.users.${conf.user} = {
    isNormalUser = true;
    description = "main user";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
    ];
    shell = pkgs.fish;
  };

  # Enable CUPS to print documents.
  services = {
    # displayManager = {
    #   autoLogin = {
    #     enable = false;
    #     inherit (conf) user;
    #   };
    #   defaultSession = "gnome";
    # };
    cron = {
      enable = true;
    };
    libinput.enable = true;
    fstrim.enable = true;
    openssh.enable = true;
    printing = {
      enable = true;
      drivers = [ pkgs.hplipWithPlugin ];
    };
    power-profiles-daemon.enable = true;
    thermald.enable = true;
    gnome.gnome-keyring.enable = true;
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
      ];
    };
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = with pkgs; [
    # Flakes clones its dependencies through the git command,
    # so git must be installed first
    vim
    curl
    nano

    fish
    nodejs

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
    tree
    exfatprogs

    # File management and archives
    p7zip
    unzip
    unrar

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
  ];
  # Set the default editor to vim
  environment.variables.EDITOR = "vim";

  system.stateVersion = "25.05"; # Did you read the comment?
}
