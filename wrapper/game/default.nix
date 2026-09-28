{ pkgs, writeScriptBin, ... }:
let
  jadeite = pkgs.callPackage ../../derivation/fetch/jadeite.nix { };

  proton = pkgs.proton-ge-bin.steamcompattool;

  # Directly use nixpkgs' proton-ge-bin package path
  set-proton-path = ''
    if [ "$WINEPREFIX" = "" ]; then WINEPREFIX=${prefix}; fi
    export WINEPREFIX
    echo "Initializing WINEPREFIX at: $WINEPREFIX"

    if [ ! -d "$WINEPREFIX/drive_c/windows/system32" ]; then
      ${pkgs.wineWowPackages.stable}/bin/wineboot -u
    fi

    if [ "$PROTONPATH" = "" ]; then
      PROTONPATH="${proton}"
    fi

    echo "using proton $PROTONPATH"
  '';

  vn-fix = writeScriptBin "vn-fix.sh" (builtins.readFile ./vn.sh);
  prefix = "$HOME/temp/prefix";

  # Removed protonup-rs execution; only runs the vn-fix script now
  game-init = writeScriptBin "game-init.sh" ''
    if [ "$WINEPREFIX" = "" ]; then WINEPREFIX=${prefix}; fi
    export WINEPREFIX
    echo "$WINEPREFIX"
    # ${vn-fix}/bin/vn-fix.sh
    vn-fix.sh lavfilters mciqtz32 mf quartz2 quartz_dx wmp11 xaudio29
  '';

  set-env = ''
    ${set-proton-path}

    export WINEDEBUG="-all"
    export WINEDLLOVERRIDES="d3d11=n;d3d12=n;dxgi=n"
    export WINEPREFIX
    export PROTONPATH

  '';

  mango-config = ''
    export MANGOHUD_CONFIG="font_size=12,preset=3"
  '';

  gamescope-arg = "-w 1920 -h 1080 -f --adaptive-sync";

  gacha-run = writeScriptBin "gacha-run.sh" ''
    ${set-env}
    LINUX_PATH="$1"

    # convert relative to absolute path
    if [ "$(printf '%s' "$LINUX_PATH" | cut -c1)" != "/" ]; then
      LINUX_PATH="$(pwd)/$LINUX_PATH"
    fi

    # wine always treat linux root folder to z: disk
    WIN_PATH="$(printf '%s' "Z:$LINUX_PATH" | sed 's|/|\\|g')"

    printf "using win path '%s'\n" "$WIN_PATH"

    exec ${pkgs.gamemode}/bin/gamemoderun \
         ${pkgs.gamescope}/bin/gamescope ${gamescope-arg} -- \
         ${pkgs.umu-launcher}/bin/umu-run \
         ${jadeite}/share/jadeite/jadeite.exe "$WIN_PATH"
  '';

  game-run = writeScriptBin "game-run.sh" ''
    ${set-env}

    exec ${pkgs.gamemode}/bin/gamemoderun \
         ${pkgs.umu-launcher}/bin/umu-run "$@"
  '';

  game-run-mango = writeScriptBin "game-mango.sh" ''
    ${set-env}
    ${mango-config}
    exec ${pkgs.gamemode}/bin/gamemoderun \
         ${pkgs.gamescope}/bin/gamescope ${gamescope-arg} -- \
         ${pkgs.mangohud}/bin/mangohud \
         ${pkgs.umu-launcher}/bin/umu-run "$@"
  '';

in
pkgs.symlinkJoin {
  name = "game";
  # buildInputs = [ pkgs.makeWrapper ];
  paths = with pkgs; [
    vn-fix
    game-run
    game-init
    gacha-run
    game-run-mango
    jadeite
    umu-launcher
    gamescope
    # mangohud
    gamemode
    lsfg-vk
    lsfg-vk-ui
    winetricks
    # protontricks
  ];
}
