-- TODO: Style wezterm tab bar.

local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder and wezterm.config_builder() or {}

-- TODO: Conditionally configure based on OS.

-- config.default_domain = "WSL:debian"
config.win32_system_backdrop = "Acrylic"
-- config.kde_window_background_blur = true

-- configs
config.color_scheme = "Catppuccin Mocha (Gogh)"
config.command_palette_font_size = 16
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 16
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.text_background_opacity = 0.9
config.use_fancy_tab_bar = false
config.window_background_opacity = 0.7
config.window_decorations = "RESIZE"
config.window_padding = {
	bottom = "12pt",
	left = "12pt",
	right = "12pt",
	top = "12pt",
}

-- events
wezterm.on("gui-startup", require("onstart").toggle_fullscreen_onstart)
wezterm.on("update-right-status", function(window, pane)
	-- TODO: Configure sophisticated status bar
	-- https://wezterm.org/config/lua/window/set_right_status.html
	window:set_right_status(wezterm.format({
		{ Text = window:active_workspace() .. "  |>  " .. require("battery"):get_battery() },
	}))
end)

-- keymaps
require("keymaps").set_keymaps(wezterm, config, act)

return config
