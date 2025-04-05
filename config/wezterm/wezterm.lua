local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- font
config.font_size = 13

-- theme
-- config.colors = {
--   background = "cyan",
-- }
config.color_scheme = "Tokyo Night (Gogh)"

-- window
config.window_background_opacity = 0.80
config.macos_window_background_blur = 20

-- hidden title bar
config.window_decorations = "RESIZE"
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}
config.window_background_gradient = {
  colors = { "#000000" },
}
config.show_new_tab_button_in_tab_bar = false

return config