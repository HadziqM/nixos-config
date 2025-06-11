{ pkgs }:

pkgs.writeShellApplication {
  name = "test-nix";
  text = ''
    echo "nix script tested"
  '';
}
