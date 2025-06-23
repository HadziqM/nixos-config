{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    pavucontrol # PulseAudio volume control GUI
    mpv # media player
    imagemagick # display(1) GUI viewer
    imv # image viewer
    swappy # screenshot annotation GUI
    yad # "Yet Another Dialog" GUI utility
    playerctl # interacts with media players (GUI usage)
    remmina # remote desktop GUI client
    arduino-ide # full GUI IDE for Arduino
    networkmanagerapplet # GUI for managing networks
    motrix
    obs-studio
  ];
}
