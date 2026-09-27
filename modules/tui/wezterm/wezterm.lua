local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback {
  'monospace',
}
config.font_size = 10.0

config.window_background_opacity = 0.95
config.text_background_opacity = 1.0

config.window_decorations = "NONE" -- Removes OS native header/titlebar frame
config.hide_tab_bar_if_only_one_tab = true -- Hide tab bar when only 1 tab is open
config.use_fancy_tab_bar = false -- Use clean, modern flat tab bar instead of OS frame
config.window_close_confirmation = 'NeverPrompt'

config.enable_csi_u_key_encoding = true
config.enable_kitty_keyboard = true

-- config.keys = {
--   {
--     key = 'V',
--     mods = 'CTRL|SHIFT',
--     action = wezterm.action.PasteFrom 'Clipboard',
--   },
-- }

config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}



-- Load Noctalia.toml if it exists
local noctalia_theme = wezterm.home_dir .. '/.config/wezterm/colors/Noctalia.toml'
local theme_file = io.open(noctalia_theme, 'r')


if theme_file then
  theme_file:close()
  config.color_scheme = 'Noctalia'
end

return config
