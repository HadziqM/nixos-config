## JOURNEY ON USING NIXOS

writing my journey on using nixos and learning it

### Timestamp

#### 2025-02-05
- installing nixos with GNOME
- understanding nix syntax and configure grub
- learn about nix-flake, nix-shell and home manager, do minimal test
- nix actually really easy, i dont understand people say steep learning curve

#### 2025-02-06
- create my on flakes, leave the hardware-configuration on system path since i m not understanding that part yet
- separate system and user package easily, i will use userpackage with unstable (rolling release) but system with versioned release (24.11)
- installing spotify need to allow unfree package setting, which is make sense
- migrating zsh,nvim and tmux dotfile into nix
- rustup and nvm isnt working here but flakes can do versioning themself in nix way

#### 2025-02-07
- use rust overlay to install rust dependencies i need, i will leave node, java, python etc on nix-develop
- mason on neovim doesnt work in nixos, i will just download the lsp from nixpkg and it working
- install my favorite shell kitty and keybind on gnome
- install hyprland but dont do anything yet since i will need some time to configure the theme
- i can use this as my everyday usage programing now
