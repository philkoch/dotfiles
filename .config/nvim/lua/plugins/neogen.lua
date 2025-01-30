return {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	lazy = true,
	keys = {
		{
			"<leader>lcc",
			function()
				require("neogen").generate({ type = "class" })
			end,
			desc = "Document Class",
		},
		{
			"<leader>lcf",
			function()
				require("neogen").generate({ type = "func" })
			end,
			desc = "Document Function",
		},
	},
	config = function()
		require("neogen").setup({
			enabled = true,
			languages = {
				python = {
					template = {
						annotation_convention = "reST",
					},
				},
			},
		})
	end,
}
