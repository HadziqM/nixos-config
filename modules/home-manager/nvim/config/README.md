# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.


## About
This Repo is my configuration for `Neovim` to match configuration of my previous repo `nvchad-config` </br>
My aim is to get full ready configuration mainly for `Rust` development


## What i change from Keymap
- Buffer manipulation matching my previous repo
- Retain `Vscode` keymap from revious repo
- Using default `Lspconfig` keymap since its match `Vscode`


## How to install
 Nvim min v.10 Required
```shell
git clone https://github.com/HadziqM/nvchad-config $HOME/.config/nvim
```
- Open nvim to install plugins
- change or the parameter in `config/overrides.lua` if you want to customize mason and treesitter to ignore or install your development kit
- add ignored folder in telescope section on `config/overrides.lua` if you have some folder you want to to exclude
- run `MasonInstallAll` on nvim to install mason binaries
- run `TSInstall rust_with_rstml` to be able to use syntax hightlighting and auto tag on rust html macro
- download `leptosfmt` from cargo to get formatter for rust
- Done
```
