{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName  = "HadziqM";
    userEmail = "dimascrazz@gmail.com";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
  };
}

