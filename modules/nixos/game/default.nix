{
  pkgs,
  ...
}:
{

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
      libva-vdpau-driver
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
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    # extraCompatPackages = with pkgs; [
    #   proton-ge-bin.steamcompattool
    # ];
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true;
    # Enables 32-bit libgamemode.so for 32-bit games & Wine prefixes
    settings = {
      general = {
        renice = 10;
      };
    };
  };
  environment.systemPackages = with pkgs; [
    gamescope
    wineWowPackages.stable
    winetricks
    mangohud

    # flashplayer
    ruffle
  ];
}
