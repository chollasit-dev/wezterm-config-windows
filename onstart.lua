local wezterm = require("wezterm")
local mux = wezterm.mux
local M = {}

function M.toggle_fullscreen_onstart(cmd)
	local tab, pane, window = mux.spawn_window({
		args = {
			"pwsh",
		},
	})
	window:gui_window():maximize()
end

return M
