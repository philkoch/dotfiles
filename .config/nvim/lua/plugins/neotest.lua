local function get_test_cwd()
	local file = vim.fn.expand("%:p")
	local match = file:match("(.-/packages/[^/]+/src)/")
	return match or vim.fn.getcwd()
end

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
				require("rustaceanvim.neotest"),
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
				require("neotest").run.run({ path = vim.fn.expand("%"), cwd = get_test_cwd() })
				require("neotest").summary.open()
			end,
			mode = "n",
			desc = "󰙨  Test current File",
		},
		{
			"<leader>tt",
			function()
				require("neotest").run.run({ cwd = get_test_cwd() })
				require("neotest").summary.open()
			end,
			mode = "n",
			desc = "󰜎   Run nearest test",
		},
		{
			"<leader>tl",
			function()
				require("neotest").run.run_last({ cwd = get_test_cwd() })
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
			"<leader>tx",
			function()
				require("neotest").run.stop()
			end,
			mode = "n",
			desc = "   Stop test run",
		},
	},
}
