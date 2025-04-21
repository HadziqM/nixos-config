{ pkgs, ... }:
let
  android = {
    versions = {
      tools = "26.1.1";
      platformTools = "35.0.1";
      buildTools = "34.0.0";
      ndk = [
        "27.2.12479018" # LTS NDK
      ];
      cmake = "3.31.6";
      emulator = "33.1.10";
    };
    platforms = [
      "30"
    ];
    abis = [
      "armeabi-v7a"
      "arm64-v8a"
    ];
    extras = [ "extras;google;gcm" ];
  };
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    toolsVersion = android.versions.tools;
    platformToolsVersion = android.versions.platformTools;
    buildToolsVersions = [ android.versions.buildTools ];
    platformVersions = android.platforms;
    abiVersions = android.abis;

    includeSources = true;
    includeSystemImages = true;
    includeEmulator = true;
    emulatorVersion = android.versions.emulator;

    includeNDK = true;
    ndkVersions = android.versions.ndk;
    cmakeVersions = [ android.versions.cmake ];

    useGoogleAPIs = true;
    includeExtras = android.extras;

    # Accepting more licenses declaratively:
    extraLicenses = [
      "android-sdk-preview-license"
      "android-googletv-license"
      "android-sdk-arm-dbt-license"
      "google-gdk-license"
      "intel-android-extra-license"
      "intel-android-sysimage-license"
      "mips-android-sysimage-license"
    ];
  };

  emulator = pkgs.androidenv.emulateApp {
    name = "emulate-MyAndroidApp";
    platformVersion = "30";
    abiVersion = "x86_64"; # mips, x86 or x86_64
    systemImageType = "google_apis_playstore";
  };

  jdk = pkgs.jdk;
in
{
  environment.systemPackages = [
    androidComposition.androidsdk
    androidComposition.platform-tools
    emulator
    jdk
    pkgs.gradle
  ];

  nixpkgs.config.android_sdk.accept_license = true;

  environment.variables = rec {
    ANDROID_SDK_ROOT = "${androidComposition.androidsdk}/libexec/android-sdk";
    ANDROID_NDK_ROOT = "${ANDROID_SDK_ROOT}/ndk-bundle";
    ANDROID_NDK_HOME = "${ANDROID_NDK_ROOT}";
    JAVA_HOME = "${jdk.home}";

    GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${ANDROID_SDK_ROOT}/build-tools/${android.versions.buildTools}/aapt2";
  };
}
