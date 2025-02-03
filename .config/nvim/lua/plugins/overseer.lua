return {
	"stevearc/overseer.nvim",
	opts = function()
		require("overseer").register_template({
			name = "poetry update",
			builder = function(params)
				return {
					cmd = "poetry",
					args = { "update" },
					name = "Poetry Update",
					cwd = vim.fn.getcwd(),
					components = { "default", "on_output_quickfix" },
				}
			end,
			priority = 50,
			condition = {
				callback = function(search)
					return vim.fn.filereadable(vim.fn.getcwd() .. "/pyproject.toml") == 1
				end,
			},
		})

		local opts = {
			task_list = {
				direction = "right",
				min_width = 40,
				max_width = 80,
			},
		}
		return opts
	end,
	keys = {
		{
			"<leader>rr",
			function()
				require("utils").run_template_open_view()
			end,
			desc = "󱜆   Template ...",
		},
		{
			"<leader>rj",
			function()
				require("utils").run_template_open_view({ name = "just qa", params = { args = {} } })
			end,
			desc = "󰙨   Just QA-recipe",
		},
		{
			"<leader>rt",
			function()
				require("overseer").toggle()
			end,
			desc = "   Task View",
		},
		{
			"<leader>rp",
			function()
				require("utils").run_template_open_view({ name = "poetry update" })
			end,
			desc = "󰁡   Poetry Update",
		},
	},
}
