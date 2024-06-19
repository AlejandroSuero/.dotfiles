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
    family = "JetBrainsMono Nerd Font",
    weight = 600,
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  },
  "Berkeley Mono",
  "nonicons",
}

config.font_size = 16

-- default is true, has more "native" look
config.use_fancy_tab_bar = false

-- I don't like putting anything at the edge if I can help it.
config.enable_scroll_bar = false

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.window_decorations = "RESIZE"

config.window_background_opacity = 0.8
local os_target = wezterm.target_triple
if string.match(os_target, "darwin") then
  config.macos_window_background_blur = 40
elseif string.match(os_target, "windows") then
  config.win32_system_backdrop = "Acrylic"
end

config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.7,
}

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

config.audible_bell = "Disabled"

config.leader = { key = ",", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
  {
    key = "w",
    mods = "LEADER",
    action = wezterm.action.CloseCurrentTab { confirm = true },
  },
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
    mods = "LEADER",
    action = action.ActivatePaneDirection "Right",
  },
  {
    key = "j",
    mods = "LEADER",
    action = action.ActivatePaneDirection "Down",
  },
  {
    key = "k",
    mods = "LEADER",
    action = action.ActivatePaneDirection "Up",
  },
  {
    key = "h",
    mods = "LEADER",
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
