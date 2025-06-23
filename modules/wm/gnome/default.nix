{ pkgs, ... }:

{

  services.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-logs
    gnomeExtensions.gsconnect
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.vitals
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.hide-top-bar
    gnomeExtensions.status-icons
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
            enabled-extensions = with pkgs.gnomeExtensions; [
              # Put UUIDs of extensions that you want to enable here.
              # If the extension you want to enable is packaged in nixpkgs,
              # you can easily get its UUID by accessing its extensionUuid
              # field (look at the following example).
              # pkgs.gnomeExtensions.gsconnect.extensionUuid
              hide-top-bar.extensionUuid
              caffeine.extensionUuid
              vitals.extensionUuid
              clipboard-indicator.extensionUuid
              tray-icons-reloaded.extensionUuid
              status-icons.extensionUuid
              gsconnect.extensionUuid
              unite.extensionUuid
              user-themes.extensionUuid
            ];
          };
        };
      }
    ];
  };
}
