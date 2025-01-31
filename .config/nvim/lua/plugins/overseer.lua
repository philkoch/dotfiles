return {
	"stevearc/overseer.nvim",
	opts = {},
	keys = {
		{
			"<leader>rr",
			function()
				require("overseer").run_template()
			end,
			desc = "󱜆   Template ...",
		},
		{
			"<leader>rj",
			function()
				require("overseer").run_template({ name = "just qa", params = { args = {} } })
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
	},
}
