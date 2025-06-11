{ pkgs }:

pkgs.writeShellApplication {
  name = "run-home";
  text = ''
    #!/usr/bin/env bash

    # Check if argument is provided
    if [ -z "$1" ]; then
      echo "Usage: input profile <in documentation eg. minimal>"
      exit 1
    fi

    PROFILE=".#$1"
    nix run home-manager/master -- switch --flake "$PROFILE" --impure
  '';
}
