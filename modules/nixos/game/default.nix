{
  pkgs,
  ...
}:
{

  jovian.steam = {
    enable = true;
    desktopSession = "niri";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      mesa-demos

      # Gstreamer full codec
      gst_all_1.gstreamer
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
      gst_all_1.gst-plugins-bad
      gst_all_1.gst-plugins-ugly
      gst_all_1.gst-libav
      gst_all_1.gst-vaapi

      ffmpeg-full
      libva # hardware accleration library for gamemode
      libva-utils
      vaapiVdpau
      libvdpau-va-gl
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [

      gst_all_1.gstreamer
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
      gst_all_1.gst-plugins-bad
      gst_all_1.gst-plugins-ugly
      gst_all_1.gst-libav

      libva
    ];
  };
  # programs.steam = {
  #   enable = true;
  #   remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  #   dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  #   localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  # };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    # the nixos-unstable gamescope is broken rn, use chaotic nyx repo
    gamescope_git
    wineWowPackages.stable
    winetricks
    lutris
    mangohud
  ];
}
