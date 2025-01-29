return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
	},
	keys = function()
		local nt = require("neotest")
		return {
			{
				"<leader>tf",
				function()
					nt.run.run(vim.fn.expand("%"))
					nt.summary.open()
				end,
				mode = "n",
				desc = "Test current File",
			},
			{
				"<leader>tl",
				function()
					nt.run.run_last()
				end,
				mode = "n",
				desc = "Run last configuration",
			},

			{
				"<leader>to",
				function()
					nt.output_panel.toggle()
				end,
				mode = "n",
				desc = "Toggle test output",
			},
			{
				"<leader>ts",
				function()
					nt.summary.toggle()
				end,
				mode = "n",
				desc = "Toggle test summary",
			},
			{
				"<leader>tt",
				function()
					nt.run.run()
					nt.summary.open()
				end,
				mode = "n",
				desc = "Run nearest test",
			},
			{
				"<leader>tx",
				function()
					nt.run.stop()
				end,
				mode = "n",
				desc = "Stop test run",
			},
		}
	end,

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
}
