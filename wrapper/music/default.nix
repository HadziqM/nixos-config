{
  pkgs,
  symlinkJoin,
  callPackage,
  writeShellApplication,
}:
let
  yt = callPackage ../../derivation/fetch/yt-dlp.nix { };

  # download music from youtube in link
  downloads-yt = writeShellApplication {
    name = "download-yt";

    runtimeInputs = [ yt ];

    text = ''
      yt-dlp \
        -x --audio-format mp3 \
        --add-metadata --embed-thumbnail \
        -o "$HOME/Music/%(title)s.%(ext)s" \
        -a ${./list.txt}
    '';
  };

  # download music backup from google drive
  downloads-gd = writeShellApplication {
    name = "download-gd";

    runtimeInputs = [ pkgs.gdown ];

    text = ''
      gdown --folder \
      "https://drive.google.com/drive/folders/1dicE8rgJospJFRAjykmNL9Ns-_XUu88A" \
      -O "$HOME/Music"
    '';
  };
in
symlinkJoin {
  name = "music";
  paths = with pkgs; [
    yt
    ffmpeg
    gdown
    termusic
    downloads-yt
    downloads-gd
    # mpd
    # mpd-discord-rpc
    # mpd-notification
    # ncmpcpp
  ];
}
