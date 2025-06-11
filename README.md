# Declarative Configuration For Standalone Nix and NixOs

## Usage

### Install Nix

In order to use this, you will first need to install Nix. You can either use
your distro's package manager, or use one of the available options to install
Nix.

- [Official Nix Installer][official-installer] - The canonical source for
  installing nix.
- [Determinate Nix Installer][detsys-installer] - A wrapper around the official
  installer that has SELinux support, and enables flake features by default.

> Note: Be advised that the Determinate Systems installer has the option for the
> official Nix as well as Determinate's own variant of Nix (Determinate Nix). It
> will prompt you for which one you want to install. System Manager is not
> tested against Determinate Nix. It's recommended to use the official Nix if
> installing via the Determinate Nix Installer.

[official-installer]: https://nixos.org/download.html
[detsys-installer]: https://github.com/DeterminateSystems/nix-installer

### Enable Flake

After installing Nix, you will need to enable flake support, preferable to use
nix-shell for the task.

```bash
nix-shell
```

Then run the installed script.

```bash
enable-flake
```

### Run the command

```bash
nix run home-manager/master -- switch --flake .#minimal --impure
```

Profile List

- `minimal`, minimal configuration for fish,zsh,tmux,yazi,git and direnv
  configuration.
- `developer`, minimal configuration with nixvim and environment variable set.
