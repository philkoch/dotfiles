return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		animate = { enabled = false },
		bigfile = { enabled = true },
		bufdelete = { enabled = true },
		dashboard = { enabled = false },
		debug = { enabled = false },
		dim = { enabled = true },
		git = { enabled = true },
		gitbrowse = { enable = false },
		indent = { enabled = true },
		input = { enabled = true },
		layout = { enabled = false },
		lazygit = { enabled = true },
		notifier = { enabled = true },
		picker = { enabled = true },
		quickfile = { enabled = true },
		rename = { enabled = false },
		scope = { enabled = false },
		scratch = { enabled = false },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		terminal = { enabled = false },
		toggle = { enabled = false },
		win = { enabled = false },
		words = { enabled = true },
		zen = { enabled = false },
	},
	keys = {
        -- stylua: ignore start	
        -- buffers
		{ "<leader>bd", function() Snacks.bufdelete() end, desc = "󰆴   Delete Buffer", },
		{ "<leader>ba", function() Snacks.bufdelete.all() end, desc = "󰗨   Delete all Buffers", },
		-- git
		{ "<leader>gb", function() Snacks.git.blame_line() end, desc = "󰮛   Git Blame Line", },
		{ "<leader>gg", function() Snacks.lazygit.open() end, desc = "   LazyGit", },
		{ "<leader>gc", function() Snacks.picker.git_log() end, desc = "   Git Log", },
        -- { "<leader>gs", function() Snacks.picker.git_status() end, desc = "󱖫   Git Status", },
		-- picker
        -- buffers
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "   Buffers" },
		{ "<leader>ft", function() Snacks.picker.grep() end, desc = "󱎸   Grep Text" },
        -- files
		{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "   Find Config File" },
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "󰱼   Find Files" },
		{ "<leader>fs", function() Snacks.picker.smart() end, desc = "󰱼   Smart Files" },
		{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "   Find Git Files" },
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "   Recent Files" },
		{ "<leader>fn", function() Snacks.picker.notifications() end, desc = "  Find Notifications" },
        -- misc
		{ "<leader>fh", function() Snacks.picker.help() end, desc = "󰾚   Find Help" },
		{ "<leader>fl", function() Snacks.picker.resume() end, desc = "󰁯   Resume last Picker" },
		{ "<leader>fi", function() Snacks.picker.icons({
              icon_sources = { "nerd_fonts", "emoji" },
              finder = "icons",
              format = "icon",
              layout = { preset = "vscode" },
              confirm = "put",
            }) end, desc = "󰊪   Icons" },
        -- LSP
		{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "   Go to definitions" },
		{ "gr", function() Snacks.picker.lsp_references() end, desc = "   Show References" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "   Go to Implementation" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "   Go to Type Definition" },

        { "<leader>lo", function() Snacks.picker.lsp_symbols() end, desc = "   Show Outline" },
        { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "   Notification History"
}
,
		--
		-- stylua: ignore end
	},
}
