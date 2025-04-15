{ pkgs, ... }:
let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    systemImageTypes = [ "google_apis_playstore" ];
    abiVersions = [
      "armeabi-v7a"
      "arm64-v8a"
    ];
    includeNDK = true;
  };
in
{
  environment.systemPackages = [
    androidComposition.androidsdk
  ];
}
