return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-neotest/neotest-python",
	},
	lazy = false,
	config = function()
		require("neotest").setup({
			quickfix = {
				open = false,
			},
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
					args = { "--cov", "-vvv", "--ignore=tests/resources/integration" },
				}),
			},
			status = {
				virtual_text = false,
				signs = true,
			},
		})
	end,
}
