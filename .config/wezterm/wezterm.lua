-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.automatically_reload_config = true

-- config.default_prog = { 'top' }

config.color_scheme = 'Dark Pastel'

config.window_background_opacity = 0.9
config.macos_window_background_blur = 25
config.dpi = 144


config.font = wezterm.font 'UbuntuMono Nerd Font'
config.font_size = 17.0

config.enable_tab_bar = false
config.window_decorations = 'RESIZE'
config.animation_fps = 9

config.window_padding = {
  left = 2,
  right = 2,
  top = 0,
  bottom = 0,
}

-- and finally, return the configuration to wezterm
return config
