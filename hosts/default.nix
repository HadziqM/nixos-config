# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  inputs,
  pkgs,
  ...
}:
let
  conf = builtins.fromJSON (builtins.readFile ../setting.json);
in
{
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
    ../modules/nixos/fonts.nix
    ../modules/nixos/bootloader.nix
    ../modules/nixos/network.nix
    ../modules/nixos/users.nix
    ../modules/nixos/audio.nix
    ../modules/nixos/gnome.nix
    ../modules/nixos/podman.nix
    ../modules/nixos/secure-dns.nix
    ../modules/nixos/flatpak.nix
    # ../modules/nixos/rust.nix
    # ../modules/nixos/tailscale.nix
    # ../modules/nixos/hyprland.nix
    ../modules/nixos/hyprland.nix
    ../modules/nixos/mimetype.nix
    # ../modules/nixos/android-dev.nix
    ../modules/nixos/gpu-driver/amd-drivers.nix
    ../modules/nixos/theme/stylix.nix
    ../modules/nixos/theme/grub-themes.nix
    ../modules/nixos/theme/sddm.nix
    ../modules/nixos/game/amd-game.nix
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };

    users = {
      ${conf.user} = import ./home-default.nix;
    };
  };

  # Enable CUPS to print documents.
  services = {
    displayManager = {
      autoLogin = {
        enable = false;
        inherit (conf) user;
      };
      defaultSession = "gnome";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
    # xserver.displayManager.gdm = {
    #   enable = true;
    #   wayland = true;
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
    power-profiles-daemon.enable = false;
    thermald.enable = true;
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
    gnome.gnome-keyring.enable = true;
    # avahi = {
    #   enable = true;
    #   nssmdns4 = true;
    #   openFirewall = true;
    # };
    # ipp-usb.enable = true;
  };

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

  nixpkgs.config.allowUnfree = true;

  # install waydroid
  virtualisation.waydroid.enable = false;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = with pkgs; [
    # Flakes clones its dependencies through the git command,
    # so git must be installed first
    vim
    curl

    # Text editors and IDEs
    nano

    # Programming languages and tools
    lua
    python3
    python3Packages.pip
    nodePackages_latest.yarn
    # gcc
    # ninja
    openssl

    # Version control and development tools
    git
    gh
    lazygit
    coreutils

    # Shell and terminal utilities
    stow
    wget
    killall
    starship
    kitty
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
    cmatrix
    fastfetch
    microfetch

    # Networking
    networkmanagerapplet
    dig
    ventoy
    remmina

    distrobox
  ];
  # Set the default editor to vim
  environment.variables.EDITOR = "vim";

  system.stateVersion = "24.11"; # Did you read the comment?
}
