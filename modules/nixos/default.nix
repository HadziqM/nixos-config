{
  imports = [

    #essential
    ./bootloader.nix
    ./network.nix
    ./secure-dns.nix
    ./tailscale.nix
    ./local-hardware-clock.nix
    ./audio.nix
    ./users.nix
    ./theme/grub-themes.nix

    # enchanchement
    ./gpu-driver/amd-drivers.nix
    ./fonts.nix
    ./flatpak.nix
    ./podman.nix
    ./vm-guest-services.nix
    ./direnv.nix

    #optionals
    ./game/amd-game.nix
    ./gnome.nix
    ./theme/sddm.nix
    # ./theme/stylix.nix
    ./shell.nix
  ];
}
