{ pkgs, ... }:

{
  services.atuin = {
    enable = true;
    openRegistration = true;
  };

  programs.starship.enable = true;

  environment.systemPackages = with pkgs; [
    atuin
  ];
}
