local status, tree = pcall(require, "nvim-tree")
if not status then
	return
end

tree.setup({
	-- sync_root_with_cwd  = true,
	-- respect_buf_cwd     = true,
	-- disable_netrw       = true,
	-- hijack_netrw        = true,
	-- open_on_setup       = false,
	-- ignore_ft_on_setup  = {},
	-- open_on_tab         = false,
	-- hijack_cursor       = false,
	-- update_cwd          = false,
	diagnostics = {
		enable = false,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	update_focused_file = {
		enable = true,
		update_root = true,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	view = {
		width = 30,
		side = "left",
		mappings = {
			custom_only = false,
			list = {},
		},
	},
	filters = {
		custom = {
			"^\\.git$",
			"^\\.env_python3.8$",
			"^.*/*.egg-info$",
			"^\\.mypy_cache$",
			"^\\.pytest_cache$",
			"^__pycache__$",
			"^\\.vscode$",
			"^\\.coverage$",
			"^cov$",
		},
	},
	git = {
		enable = true,
		ignore = false,
	},
})
