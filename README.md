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


#### 2025-02-11
- adding some necessaries desktop utilities, obsidian, onlyoffice, etc.
- there is a problem that i got disk unmounted without being umount after like 5 hours session, its serrious problem
- this problem actually occur a day after i install nixos
- change the kernel into zen and add kernel parameter especially for powerconsumpton and idle on amd and nvme

#### 2025-02-12
- configuring stylix to theme gtk and qt apps
- the qt part of stylix is still limited
- kernel change and kernel param still doesnt solve the problem about the instability, its still unusable after 5 hours session
- adding nix-ld to config to make neovim easier to use with lazyvim


#### 2025-02-13
- add some my hyprland config a little
- i noticed the neovim error when updating, sync etc. turn out it because file handled by home manager is read-only, it conflict with lazyvim as it has own manager and it periodically want to edit lock file
- i suspect the neovim is source of instability, since most of time it occure when neovim stuck with something
- learning nixvim

#### 2025-02-14
- adding wireguard vpn, its handy to bypass captive portal used by my university to limit internet connection
