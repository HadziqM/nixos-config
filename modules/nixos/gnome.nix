{ pkgs, ... }:

{
  # Enable the X11 windowing system.

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-music
    gnome-logs
    gnomeExtensions.gsconnect
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.vitals
  ];

  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        lockAll = false;
        settings = {
          "org/gnome/desktop/interface".color-scheme = "prefer-dark";
          "org/gnome/shell" = {
            disable-user-extensions = false; # enables user extensions
            enabled-extensions = [
              # Put UUIDs of extensions that you want to enable here.
              # If the extension you want to enable is packaged in nixpkgs,
              # you can easily get its UUID by accessing its extensionUuid
              # field (look at the following example).
              pkgs.gnomeExtensions.gsconnect.extensionUuid
              pkgs.gnomeExtensions.caffeine.extensionUuid
              pkgs.gnomeExtensions.vitals.extensionUuid
              pkgs.gnomeExtensions.clipboard-indicator.extensionUuid
            ];
          };
        };
      }
    ];
  };
}
