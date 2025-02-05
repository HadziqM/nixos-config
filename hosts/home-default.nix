{ pkgs, ... }: 
{

  imports = [
    ../modules/home-manager/git.nix
    ../modules/home-manager/nvim/conf.nix
  ];

  home.username = "hadziq";
  home.homeDirectory = "/home/hadziq";

  programs.bash.enable = true;
  programs.bash.shellAliases = {
    ll = "ls -l";
  };

  home.packages = with pkgs; [
    htop
  ];

  home.stateVersion = "23.11"; # Make sure to set this to your NixOS version
}
