{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.cli-tools.setting;
in
{
  options.cli-tools.setting = {
    enable = mkEnableOption "enable essential tools";
    monitoring = mkEnableOption "enable monitoring tool";
    flex = mkEnableOption "enable flex tools";
  };

  config = mkIf cfg.enable {
    home.packages =
      with pkgs;
      # Essential tools (always included when enable = true)
      [
        # System info
        neofetch
        microfetch
        # File management
        yazi
        # Archives
        zip
        xz
        unzip
        p7zip
        # Utils
        ripgrep
        jq
        yq-go
        eza
        fzf
        bat # for fish aliases and functions
        zoxide
        gawk
        zstd

        zellij
      ]
      # Monitoring tools
      ++ optionals cfg.monitoring [
        btop
        iotop # io monitoring
        iftop # network monitoring
        # System call monitoring
        strace # sys call monitoring
        ltrace # lib call monitoring
        lsof # list open files
        # System tools
        sysstat
        lm_sensors
        ethtool
        pciutils
        usbutils
      ]
      # Flexible/Additional tools
      ++ optionals cfg.flex [
        wlr-randr
        mtr
        iperf3
        dnsutils
        ldns
        aria2
        socat
        nmap
        ipcalc
        cmatrix
        cowsay
      ];
  };
}
