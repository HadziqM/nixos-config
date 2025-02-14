-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local M = {
  -- normal mode
  n = {
    --split screen
    ["-"] = { ":split<cr>", "split screen horizontal" },
    ["|"] = { ":vsplit<cr>", "split screen vertical" },
    ["<F2>"] = { ":on<cr>", "delete all buffer/tabs" },
    --buffer action
    ["<Tab>"] = { ":bnext<cr>", "buffer/tabs next" },
    ["<C-Tab>"] = { ":bd<cr>", "delete buffer/tabs" },
    ["<S-Tab>"] = { ":bprev<cr>", "buffer/tabs prev" },
    --buffer resize
    ["<C-S-Right>"] = { ":vertical resize +2<cr>", "resize right" },
    ["<C-S-Left>"] = { ":vertical resize -2<cr>", "resize left" },
    ["<C-S-Up>"] = { ":resize -2<cr>", "resize up" },
    ["<C-S-Down>"] = { ":resize +2<cr>", "resize down" },
    --buffer move
    ["<C-Right>"] = { "<C-w><Right>", "hover/change buffer right" },
    ["<C-Left>"] = { "<C-w><Left>", "hover/chnage buffer left" },
    ["<C-Up>"] = { "<C-w><Up>", "hover/change buffer up" },
    ["<C-Down>"] = { "<C-w><Down>", "hover/change buffer down" },
    --select all
    ["<C-a>"] = { "gg<S-v>G", "select all" },
    --vscode copy
    --move line
    ["<M-Up>"] = { ":m .-2<cr>==", "move line up" },
    ["<M-Down>"] = { ":m .+1<cr>==", "move line down" },
    --copy line+move
    ["<M-S-Up>"] = { "yyP<end>", "copy line up" },
    ["<M-S-Down>"] = { "yyp<end>", "copy line down" },
    --indent
    --debugging actions
    ------ just use > or <
    -- ToogleTerm
    ["<M-h>"] = { ":ToggleTerm size=30 direction=horizontal<CR>", "Terminal Horizontal" },
    ["<M-i>"] = { ":ToggleTerm direction=float<CR>", "Terminal Float" },
    ["<M-v>"] = { ":ToggleTerm size=30 direction=vertical<CR>", "Terminal Vertical" },
    ["<M-t>"] = { ":ToggleTerm direction=tab<CR>", "Terminal Tab" },

    -- Comment
    ["<leader>/"] = { "gcc", "comment line" },
  },
  -- visual mode
  v = {
    --copy vscode
    --move selected
    ["<M-Up>"] = { ":m '<-2<cr>gv-gv", "move selected up" },
    ["<M-Down>"] = { ":m '>+1<cr>gv-gv", "move selected down" },
    --copy selected+move
    ["<M-S-Up>"] = { "y`]p`]gv-gv", "copy selected up" },
    ["<M-S-Down>"] = { "yP`[gv-gv", "copy selected down" },
    --Comment
    ["<leader>/"] = { "gc", "comment line" },
  },
  -- insert mode
  i = {
    --vscode copy
    --move line
    ["<M-Up>"] = { "<esc>:m .-2<cr>==", "move line up" },
    ["<M-Down>"] = { "<esc>:m .+1<cr>==", "move line down" },
    --copy line+move
    ["<M-S-Up>"] = { "<esc>yyP<end>", "copy line up " },
    ["<M-S-Down>"] = { "<esc>yyp<end>", "copy line down" },
    --convinient
    ["<C-x>"] = { "<C-o>dd", "cut line" },
    ["<C-a>"] = { "<esc>gg<S-v>G", "select all" },
    ["<C-v>"] = { "<C-o>v<S-Right>", "go to visual" },
    ["<C-S-v>"] = { "<esc>pi", "paste" },
    ["<S-Right>"] = { "<C-Right>", "move next word" },
    ["<S-Left>"] = { "<C-Left>", "move prev word" },
  },



  t = {
    ["<C-Right>"] = { "<C-w><Right>", "hover/change buffer right" },
    ["<C-Left>"] = { "<C-w><Left>", "hover/chnage buffer left" },
    ["<C-Up>"] = { "<C-w><Up>", "hover/change buffer up" },
    ["<C-Down>"] = { "<C-w><Down>", "hover/change buffer down" },
  },
}

for mode, keymaps in pairs(M) do
  for key, val in pairs(keymaps) do
    vim.keymap.set(mode, key, val[1], { desc = val[2] })
  end
end
