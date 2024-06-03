-- treesitter for code parsing
return {
	"nvim-treesitter/nvim-treesitter",
	lazy = true,
	build = function()
		local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
		ts_update()
	end,
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
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
				additional_vim_regex_highlighting = false,
			},
		})
	end,
}
