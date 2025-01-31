return {
	"nvim-neotest/neotest",
	lazy = true,
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
		{ "nvim-treesitter/nvim-treesitter", lazy = true },
		{ "nvim-neotest/neotest-python", lazy = true },
	},
	config = function()
		require("neotest").setup({
			quickfix = {
				open = false,
			},
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
					args = { "-vvv", "--ignore=tests/resources/integration" },
				}),
			},
			status = {
				virtual_text = false,
				signs = true,
			},
		})
	end,
	keys = {
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
				require("neotest").summary.open()
			end,
			mode = "n",
			desc = "󰙨  Test current File",
		},
		{
			"<leader>tl",
			function()
				require("neotest").run.run_last()
			end,
			mode = "n",
			desc = "󰁯   Run last configuration",
		},

		{
			"<leader>to",
			function()
				require("neotest").output_panel.toggle()
			end,
			mode = "n",
			desc = "   Toggle test output",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			mode = "n",
			desc = "   Toggle test summary",
		},
		{
			"<leader>tt",
			function()
				require("neotest").run.run()
				require("neotest").summary.open()
			end,
			mode = "n",
			desc = "󰜎   Run nearest test",
		},
		{
			"<leader>tx",
			function()
				require("neotest").run.stop()
			end,
			mode = "n",
			desc = "   Stop test run",
		},
	},
}
