local workspace = require("workspaces")
local M = {}

function M.set_keymaps(wezterm, config, act)
	local act_callback = wezterm.action_callback

	config.keys = {
		-- inner
		{
			key = "K",
			mods = "CTRL|SHIFT",
			-- NOTE: Modify from default.
			action = act.Multiple({
				act.ClearScrollback("ScrollbackAndViewport"),
				act.SendKey({ key = "L", mods = "CTRL" }),
			}),
		},

		-- scroll
		{ key = "UpArrow", mods = "SHIFT", action = act.ScrollByLine(-1) },
		{ key = "DownArrow", mods = "SHIFT", action = act.ScrollByLine(1) },

		-- pane
		-- TODO: Set split based on current domain (pwsh, WSL2)
		-- {
		-- 	key = "h",
		-- 	mods = "ALT",
		-- 	action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		-- },
		-- {
		-- 	key = "v",
		-- 	mods = "ALT",
		-- 	action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		-- },

		-- tab
		-- TODO: Automatically set tab title beautifully.
		-- https://wezterm.org/config/lua/keyassignment/PromptInputLine.html#example-of-interactively-renaming-the-current-tab
		{
			key = "0",
			mods = "CTRL",
			action = act.SpawnCommandInNewTab({ args = { "pwsh" } }),
		},
		{
			key = "1",
			mods = "CTRL",
			action = act.SpawnTab({ DomainName = "WSL:Debian" }),
		},
		{
			key = "2",
			mods = "CTRL",
			action = act.SpawnTab({ DomainName = "WSL:NixOS" }),
		},

		-- list panel
		{ key = "l", mods = "ALT", action = act.ShowLauncher },
		{
			key = "t",
			mods = "ALT",
			action = act.ShowTabNavigator,
		},
		{ key = "w", mods = "ALT", action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}) },

		-- workspace
		{
			key = "0",
			mods = "ALT",
			action = act.SwitchToWorkspace({
				name = "default",
			}),
		},
		{
			key = "1",
			mods = "ALT",
			action = act.SwitchToWorkspace(workspace.job_project),
		},
		{
			key = "2",
			mods = "ALT",
			action = act.Multiple({
				act.SwitchToWorkspace(workspace.side_project),
			}),
		},
		{
			key = "3",
			mods = "ALT",
			action = act.SwitchToWorkspace(workspace.dotfiles),
		},
		{
			key = "4",
			mods = "ALT",
			action = act.SwitchToWorkspace(workspace.nix),
		},
		{
			key = "5",
			mods = "ALT",
			action = act.SwitchToWorkspace(workspace.nvim_config),
		},

		-- Prompt for a workspace name, then switch to it.
		{
			key = "w",
			mods = "ALT|SHIFT",
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Enter name for new workspace" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:perform_action(
							act.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					end
				end),
			}),
		},
	}
end

return M
