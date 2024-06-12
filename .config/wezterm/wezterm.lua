local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 11.0
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = .75

return config
