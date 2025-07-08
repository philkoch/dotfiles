return {
	"stevearc/overseer.nvim",
	opts = function()
		require("overseer").register_template({
			name = "poetry install",
			builder = function(params)
				return {
					cmd = "poetry",
					args = { "install" },
					name = "Poetry Install",
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
		require("overseer").register_template({
			name = "poetry lock",
			builder = function(params)
				return {
					cmd = "poetry",
					args = { "lock" },
					name = "Poetry Lock",
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
		require("overseer").register_template({
			name = "poetry sync",
			builder = function(params)
				return {
					cmd = "poetry",
					args = { "sync" },
					name = "Poetry Sync",
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
		require("overseer").register_template({
			name = "docker build AITASTIC",
			builder = function(params)
				return {
					cmd = "docker",
					args = {
						"build",
						"--secret",
						"id=GOOGLE_APPLICATION_CREDENTIALS",
						"--tag",
						-- setting tag to current directory name with arbitrary version 1.0.0
						"aitastic/"
							.. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
							.. ":1.0.0",
						".",
					},
					name = "Docker Build AITASTIC",
					cwd = vim.fn.getcwd(),
					env = {
						GOOGLE_APPLICATION_CREDENTIALS = os.getenv("GCP_APPLICATION_CREDENTIALS"),
					},
					components = { "default", "on_output_quickfix" },
				}
			end,
			priority = 50,
			condition = {
				callback = function(search)
					return vim.fn.filereadable(vim.fn.getcwd() .. "/Dockerfile") == 1
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
			"<leader>rpu",
			function()
				require("utils").run_template_open_view({ name = "poetry update" })
			end,
			desc = "󰁡   Poetry Update",
		},
		{
			"<leader>rpi",
			function()
				require("utils").run_template_open_view({ name = "poetry install" })
			end,
			desc = "  Poetry Install",
		},
		{
			"<leader>rpl",
			function()
				require("utils").run_template_open_view({ name = "poetry lock" })
			end,
			desc = "  Poetry Lock",
		},
		{
			"<leader>rps",
			function()
				require("utils").run_template_open_view({ name = "poetry sync" })
			end,
			desc = "  Poetry Sync",
		},
		{
			"<leader>rd",
			function()
				require("utils").run_template_open_view({ name = "docker build AITASTIC" })
			end,
			desc = "   Docker Build AITASTIC",
		},
	},
}
