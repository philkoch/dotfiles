return {
	"numToStr/FTerm.nvim",
	keys = {
		{
			"<C-t>",
			function()
				require("FTerm").toggle()
			end,
			desc = "Open Floating Term",
			mode = "n",
		},
		{
			"<C-t>",
			function()
				require("FTerm").toggle()
			end,
			desc = "Close Floating Term",
			mode = "t",
		},
	},
	config = function()
		require("FTerm").setup({
			border = "single",
			dimensions = {
				height = 0.9,
				width = 0.9,
			},
		})
	end,
}
