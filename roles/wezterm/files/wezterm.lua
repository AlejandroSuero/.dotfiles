-- Pull in the wezterm API
local wezterm = require "wezterm"

local action = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'Batman'

-- Set background to same color as neovim
config.colors = {}
config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font_with_fallback {
  {
    family = "JetBrainsMono Nerd Font Mono",
    weight = 600,
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  },
  "Berkeley Mono",
  "nonicons",
}

config.font_size = 10

-- default is true, has more "native" look
config.use_fancy_tab_bar = false

-- I don't like putting anything at the ege if I can help it.
config.enable_scroll_bar = false

config.window_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 5,
}

config.window_decorations = "RESIZE"

config.window_background_opacity = 0.8

config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.7,
}

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

config.leader = { key = " ", mods = "SHIFT", timeout_milliseconds = 2000 }
config.keys = {
  {
    key = "c",
    mods = "LEADER",
    action = action.SpawnTab "CurrentPaneDomain",
  },
  {
    key = "J",
    mods = "LEADER",
    action = action.SplitVertical { domain = "CurrentPaneDomain" },
  },
  {
    key = "L",
    mods = "LEADER",
    action = action.SplitVertical { domain = "CurrentPaneDomain" },
  },
  {
    key = "l",
    mods = "LEADER|CTRL",
    action = action.ActivatePaneDirection "Right",
  },
  {
    key = "j",
    mods = "LEADER|CTRL",
    action = action.ActivatePaneDirection "Down",
  },
  {
    key = "k",
    mods = "LEADER|CTRL",
    action = action.ActivatePaneDirection "Up",
  },
  {
    key = "h",
    mods = "LEADER|CTRL",
    action = action.ActivatePaneDirection "Left",
  },
  {
    key = "r",
    mods = "LEADER",
    action = action.ReloadConfiguration,
  },
  {
    key = "R",
    mods = "LEADER",
    action = action.PromptInputLine {
      description = "Enter new name for tab",
      action = wezterm.action_callback(function(window, _, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
}

-- and finally, return the configuration to wezterm
return config
