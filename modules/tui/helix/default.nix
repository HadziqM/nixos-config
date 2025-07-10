{ pkgs, ... }:
{
  stylix.targets.helix.enable = false;
  home.packages = with pkgs; [
    svelte-language-server
    typescript-language-server
    vscode-langservers-extracted
  ];
  programs.helix = {
    enable = true;
    settings = {
      theme = "mocha_transparent";
      editor = {
        file-picker.hidden = false;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
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
        {
          name = "rust";
          formatter = {
            command = "rustfmt";
          };
        }
        {
          name = "svelte";
          language-servers = [
            "svelteserver"
            "tailwind"
          ];
        }
      ];
      language-server = {
        sqls = {
          command = "${pkgs.sqlint}/bin/sqlint";
        };
        statix = {
          command = "${pkgs.statix}/bin/statix";
        };
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
        };
        tailwind = {
          command = "${pkgs.tailwindcss-language-server}/bin/tailwindcss-language-server";
          args = [ "--stdio" ];
        };
        rust-analyzer = {
          config.check.command = "clippy";
        };
      };
    };
    themes = {
      mocha_transparent = {
        "inherits" = "catppuccin_mocha";
        "ui.background" = { };
      };
    };
  };
}
