{ pkgs, ... }:
let
  hx-lsp = pkgs.rustPlatform.buildRustPackage {
    pname = "hx-lsp";
    version = "0.2.11";

    src = pkgs.fetchFromGitHub {
      owner = "erasin";
      repo = "hx-lsp";
      rev = "0.2.11";
      sha256 = "sha256-wTilbEK3BZehklAd+3SS2tW/vc8WEeMPUsYdDVRC/Ho=";
    };

    cargoHash = "sha256-dcGInrfWftClvzrxYZvrazm+IWWRfOZmxDJPKwu7GwM=";

    meta = with pkgs.lib; {
      description = "lsp for helix , support snippets, actions";
      homepage = "https://github.com/erasin/hx-lsp";
      license = licenses.mit;
      maintainers = [ ];
    };
  };
in
{
  stylix.targets.helix.enable = false;
  home.packages = with pkgs; [
    svelte-language-server
    typescript-language-server
    vscode-langservers-extracted
  ];
  home.file = {
    ".config/helix/snippets".source = ../../../asset/snippet;

    ".ignore".text = ''
      # Version control directories
      .git/
      .svn/
      .hg/
      .bzr/

      # Build directories
      target/
      build/
      dist/
      out/

      # Dependencies
      node_modules/
      .pnpm-store/
      .yarn/
      vendor/

      .direnv/
    '';
  };
  programs.helix = {
    enable = true;
    settings = {
      theme = "mocha_transparent";
      editor = {
        file-picker = {
          hidden = false;
          ignore = true;
        };
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
        {
          name = "dart";
          language-servers = [
            "dart"
            "hx-lsp"
          ];
        }
      ];
      language-server = {
        hx-lsp.command = "${hx-lsp}/bin/hx-lsp";
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
