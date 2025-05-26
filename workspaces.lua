local M = {}

M.default = {
	name = "default",
	spawn = {
		args = { "pwsh" },
	},
}

M.job_project = {
	name = "Job",
	spawn = {
		args = { "wsl", "-d", "debian", "--cd", "~/projects/job/permanent/level11" },
	},
}

M.side_project = {
	name = "Personal",
	spawn = {
		args = { "wsl", "-d", "debian", "--cd", "~/projects/personal" },
	},
}

M.dotfiles = {
	name = "Dotfiles",
	spawn = {
		args = { "wsl", "-d", "debian", "--cd", "~/.dotfiles" },
	},
}

M.nix = {
	name = "Nix",
	spawn = {
		args = { "wsl", "-d", "debian", "--cd", "~/nix" },
	},
}

M.nvim_config = {
	name = "Neovim Config",
	spawn = {
		args = { "wsl", "-d", "debian", "--cd", "~/.config/nvim" },
	},
}

return M
