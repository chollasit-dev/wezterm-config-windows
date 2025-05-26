local wezterm = require("wezterm")
local M = {}

-- "Wed Mar 3 08:14"
local date = wezterm.strftime("%a %b %-d %H:%M ")

local battery = ""
for _, b in ipairs(wezterm.battery_info()) do
	battery = "🔋" .. string.format("%.0f%%", b.state_of_charge * 100)
end

function M.get_battery()
	return battery .. "  " .. date
end

return M
