return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
	lazy = false,
	config = function()
		local function wide_enough(min_width)
			return function()
				return vim.fn.winwidth(0) > min_width
			end
		end

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {},
				lualine_x = {
					{
						"encoding",
						-- Override 'encoding': Don't display if encoding is UTF-8.
						encoding = function()
							local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
							return ret
						end,
						cond = wide_enough(80),
					},
					{
						"fileformat",
						-- fileformat: Don't display if &ff is unix.
						fileformat = function()
							local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
							return ret
						end,
						cond = wide_enough(80),
					},
					{ "filetype", cond = wide_enough(60) },
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {},
			tabline = {},
			winbar = {
				lualine_a = {},
				lualine_b = { { "filename", path = 1 } },
				lualine_c = { "diagnostics" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			inactive_winbar = {
				lualine_a = {},
				lualine_b = { { "filename", path = 1 } },
				lualine_c = { "diagnostics" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "quickfix" },
		})
	end,
}