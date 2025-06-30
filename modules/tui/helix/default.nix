{ pkgs, ... }:
{
  stylix.targets.helix.enable = false;
  home.packages = with pkgs; [
    svelte-language-server
    tailwindcss-language-server
    typescript-language-server
    vscode-langservers-extracted
  ];
  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox_transparent";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
          language-servers = [
            "nixd"
            "statix"
          ];
        }
        {
          name = "sql";
          language-servers = [ "sqls" ];
        }
      ];
      language-server = {
        sqls = {
          command = "${pkgs.sqls}/bin/sqls";
        };
        statix = {
          command = "${pkgs.statix}/bin/statix";
        };
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
        };
        rust-analyzer = {
          config.check.command = "${pkgs.clippy}/bin/clippy";
        };
      };
    };
    themes = {
      gruvbox_transparent = {
        "inherits" = "gruvbox";
        "ui.background" = { };
      };
    };
  };
}
