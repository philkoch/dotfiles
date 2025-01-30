-- treesitter for code parsing
return {
	"nvim-treesitter/nvim-treesitter",
	lazy = true,
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-context", lazy = true },
	},
	build = function()
		local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
		ts_update()
	end,
	ft = { "python", "rust", "lua", "markdown", "txt" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "c", "lua", "vim", "help", "python", "rust" },
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,
			-- installs new parsers automatically when a buffer containing the language
			-- is opened for the first time
			auto_install = true,
			-- List of parsers to ignore installing (for "all")
			-- ignore_install = { "javascript" },
			highlight = {
				enable = true,
				-- disables highlighting when this function returns true
				disable = function(lang, buf)
					if lang == "" or lang == nil then
						return true
					end
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
				additional_vim_regex_highlighting = false,
			},
		})
		require("treesitter-context").setup({
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			line_numbers = true,
			multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
			trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
			zindex = 20, -- The Z-index of the context window
		})
	end,
}
