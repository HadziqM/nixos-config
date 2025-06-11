{
  pkgs ? import <nixpkgs> { },
}:
let
  # Get the list of all files in the scripts directory
  scriptFiles = builtins.attrNames (builtins.readDir ./scripts);
  # Filter for only .nix files
  nixFiles = builtins.filter (file: builtins.match ".*\\.nix$" file != null) scriptFiles;
  # Import each .nix script as a module
  scripts = builtins.map (file: import (./scripts + "/${file}") { inherit pkgs; }) nixFiles;
in
pkgs.mkShell {
  buildInputs = scripts;
}
