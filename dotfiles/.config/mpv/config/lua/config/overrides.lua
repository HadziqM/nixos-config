local overrides = {}

overrides.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "arduino",
    "astro",
    "cmake",
    "cpp",
    "csv",
    "go",
    "htmldjango",
    "json",
    "python",
    "rust",
    "sql",
    "svelte",
    "toml",
    "vue",
    "xml",
    "yaml",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
  autotag = {
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
    filetypes = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
      "tsx",
      "jsx",
      "rescript",
      "xml",
      "php",
      "markdown",
      "astro",
      "glimmer",
      "handlebars",
      "hbs",
      "rust",
    },
  },
}

overrides.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    -- "htmx-lsp", --experimental new lsp
    "typescript-language-server",
    "svelte-language-server",
    "astro-language-server",
    -- "vetur-vls", --vue lsp
    "tailwindcss-language-server",
    -- "deno",
    -- "prettier",
    -- for djinja or django templating
    -- "djlint",
    -- "python-lsp-server",

    --data/content general
    "json-lsp",
    "markdownlint",
    "marksman",
    "sqlls", --golang version of sqlls
    "sqlfmt",
    "yaml-language-server",
    "yamlfmt",
    "yamllint",

    --rust
    "rust-analyzer",
    "taplo", --for toml lsp

    -- nix
    "rnix-lsp",

    --solidity
    -- "solidity",

    -- c/cpp stuff
    -- "clangd",
    -- "clang-format",
    -- "cmake-language-server",

    --go
    -- "gopls",
    -- "goimports",

    --godot
    -- "gdtoolkit",

    --proxy or container
    -- "docker-compose-language-service",
    -- "dockerfile-language-server",
    -- "nginx-language-server",

    --arduino
    -- "arduino-language-server",
  },
}

-- git support in neo-tree
overrides.neotree = {

  -- use icon in git status but doesnt hide ignore from file tree
  filesystem = {
    filtered_items = {
      visible = true,
      show_hidden_count = true,
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_by_name = {
        -- '.git',
        -- '.DS_Store',
        -- 'thumbs.db',
      },
      never_show = {},
    },
  },
}

-- Telescope config
overrides.telescope = {
  default = {
    -- ignore folder
    file_ignore_patterns = {
      "yarn%.lock",
      "node_modules/",
      "raycast/",
      "dist/",
      "%.next",
      "%.git/",
      "%.gitlab/",
      "build/",
      "target/",
      "package%-lock%.json",
      ".git/",
      ".sqlx/",
    },
  },
}

return overrides
