{ pkgs }:

pkgs.writeShellApplication {
  name = "allocate-swap";
  text = ''
    #!/usr/bin/env bash

    # Check if argument is provided
    if [ -z "$1" ]; then
      echo "Usage: allocate-swap <size_in_GB>"
      exit 1
    fi

    # Swap size in GB
    SWAP_SIZE="$1G"

    # Check if swapfile already exists
    if [ -f /swapfile ]; then
      echo "Swapfile already exists. Do you want to recreate it? (y/N)"
      read -r answer
      if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
        echo "Aborting."
        exit 0
      fi
      sudo swapoff /swapfile
      sudo rm -f /swapfile
    fi

    # Create swapfile
    sudo fallocate -l "$SWAP_SIZE" /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile

    # Add to /etc/fstab if not already present
    if ! grep -q "/swapfile" /etc/fstab; then
      echo "/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab
    fi

    echo "Swapfile of size $SWAP_SIZE created and enabled successfully."
  '';
}
