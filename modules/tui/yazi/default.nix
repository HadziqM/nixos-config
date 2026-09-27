{ pkgs, ... }:

let
  yz = pkgs.yazi.override { _7zz = pkgs._7zz-rar; };
  term-open = pkgs.writeShellApplication {
    name = "term-open";
    runtimeInputs = [
      pkgs.wezterm
      pkgs.foot
    ];
    text = ''
      CWD=""
            HOLD=false

            while [ $# -gt 0 ]; do
              case "$1" in
                --cwd)
                  if [ $# -gt 1 ]; then
                    CWD="$2"
                    shift 2
                  else
                    shift 1
                  fi
                  ;;
                --hold)
                  HOLD=true
                  shift 1
                  ;;
                *)
                  break
                  ;;
              esac
            done

            TERM_BIN="''${TERMINAL:-wezterm}"

            if [[ "$TERM_BIN" == *"foot"* ]]; then
              ARGS=()
              [ -n "$CWD" ] && ARGS+=("-D" "$CWD")
              [ "$HOLD" = true ] && ARGS+=("-H")
              if [ $# -gt 0 ]; then
                exec foot "''${ARGS[@]}" "$@"
              else
                exec foot "''${ARGS[@]}"
              fi
            else
              ARGS=("start")
              [ -n "$CWD" ] && ARGS+=("--cwd" "$CWD")
              
              if [ "$HOLD" = true ]; then
                if [ $# -gt 0 ]; then
                  exec wezterm "''${ARGS[@]}" -- sh -c '"$@"; echo "Press enter to exit..."; read' _ "$@"
                else
                  exec wezterm "''${ARGS[@]}"
                fi
              else
                if [ $# -gt 0 ]; then
                  exec wezterm "''${ARGS[@]}" -- "$@"
                else
                  exec wezterm "''${ARGS[@]}"
                fi
              fi
            fi      
    '';
  };
in
{
  packages = [
    term-open
    yz
  ];

  files.".config/yazi/yazi.toml" = {
    generator = (pkgs.formats.toml { }).generate "yazi.toml";
    value = {
      opener = {
        exe = [
          {
            run = ''WINEDLLOVERRIDES="version=n,b" term-open --hold game-run.sh "$@"'';
            orphan = true;
            desc = "Open with umu launcher";
          }
          {
            run = ''WINEDLLOVERRIDES="version=n,b" term-open --hold game-mango.sh "$@"'';
            orphan = true;
            desc = "Open with umu launcher + mangohud";
          }
          {
            run = ''WINEDLLOVERRIDES="version=n,b" WINEPREFIX=$HOME/.wine term-open --hold game-run.sh "$@"'';
            orphan = true;
            desc = "Open using .wine prefix";
          }
          {
            run = ''WINEDLLOVERRIDES="version=n,b" WINEPREFIX=$HOME/.wine term-open --hold game-mango.sh "$@"'';
            orphan = true;
            desc = "Open using .wine prefix + mangohud";
          }
          {
            run = ''WINEDLLOVERRIDES="version=n,b" term-open --hold gacha-run.sh "$@"'';
            orphan = true;
            desc = "Open gacha game patched";
          }
          {
            run = ''WINEDLLOVERRIDES="version=n,b" term-open --hold firejail --noprofile --net=none --allow-bwrap -- game-run.sh "$@"'';
            orphan = true;
            desc = "Open with internet block";
          }
        ];
        edit = [
          {
            run = ''term-open --hold hx "$@"'';
            desc = "Using helix editor";
          }
        ];
        open_terminal = [
          {
            run = ''term-open --cwd "$1"'';
            orphan = true;
            desc = "Open terminal here";
          }
          {
            run = ''term-open --cwd "$1" zellij'';
            orphan = true;
            desc = "Open terminal with zellij here";
          }
        ];
      };

      open = {
        prepend_rules = [
          {
            url = "*.exe";
            use = "exe";
          }
          {
            url = "*.bat";
            use = "exe";
          }
          {
            url = "*.msi";
            use = "exe";
          }
          {
            url = "*/";
            use = [ "open_terminal" ];
          }
        ];
        append_rules = [
          {
            url = "*";
            use = "edit";
          }
        ];
      };
    };
  };
}
