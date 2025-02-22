return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
	lazy = false,
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = {
					{
						"encoding",
						-- Override 'encoding': Don't display if encoding is UTF-8.
						encoding = function()
							local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
							return ret
						end,
					},
					{
						"fileformat",
						-- fileformat: Don't display if &ff is unix.
						fileformat = function()
							local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
							return ret
						end,
					},
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = { "quickfix" },
		})
	end,
}
