{
  pkgs,
  lib,
  ...
}:

let
  tomlFormat = pkgs.formats.toml { };

  # Server list for Nix language support
  nixLanguageServers = [
    "statix"
    "nixd"
  ];
in
{
  # 1. Install Helix and language server packages
  packages = with pkgs; [
    helix
    nixfmt
    statix
    nixd
    hx-lsp
  ];

  files.".config/helix/config.toml" = {
    generator = tomlFormat.generate "helix-config.toml";
    value = {
      theme = "noctalia";

      editor = {
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        file-picker = {
          hidden = false;
          ignore = true;
        };
      };
    };
  };

  # 3. Languages Configuration (~/.config/helix/languages.toml)

  files.".config/helix/themes/mocha_transparent.toml" = {
    generator = tomlFormat.generate "mocha.toml";
    value = {
      inherits = "catppuccin_mocha";
      ui.background = { };
    };
  };

  files.".config/helix/languages.toml" = {
    generator = tomlFormat.generate "helix-languages.toml";
    value = {
      language = [
        {
          name = "nix";
          auto-format = true;
          language-servers = nixLanguageServers;
          formatter = {
            command = lib.getExe pkgs.nixfmt;
          };
        }
        {
          name = "rust";
          language-servers = [
            "rust-analyzer"
            "hx-lsp"
          ];
          formatter = {
            command = "rustfmt";
          };
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
        statix = {
          command = lib.getExe pkgs.statix;
        };

        rust-analyzer = {
          config = {
            check = {
              command = "clippy";
            };
          };
        };

        nixd = {
          command = lib.getExe pkgs.nixd;
        };
        hx-lsp = {
          command = lib.getExe pkgs.hx-lsp;
        };
      };
    };
  };

  # 4. Global Ignore Rules (~/.config/helix/ignore)
  files.".config/helix/ignore".text = ''
    .git/
    .svn/
    .hg/
    .bzr/

    target/
    build/
    dist/
    out/

    node_modules/
    .pnpm-store/
    .yarn/
    vendor/

    .direnv/
  '';
}
