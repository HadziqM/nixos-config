{ pkgs }:

pkgs.writeShellApplication {
  name = "enable-flake";
  text = ''
    # Ensure the config directory exists
    mkdir -p ~/.config/nix

    # Check if flakes are already enabled
    if ! grep -q "experimental-features = nix-command flakes" ~/.config/nix/nix.conf 2>/dev/null; then
      echo "Enabling flakes and nix-command..."
      echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
      echo "Successfully enabled flakes."
    else
      echo "Flakes are already enabled."
    fi
  '';
}
