return {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	lazy = true,
	keys = function()
		local neogen = require("neogen")
		return {
			{
				"<leader>lcc",
				function()
					neogen.generate({ type = "class" })
				end,
				desc = "Document Class",
			},
			{
				"<leader>lcf",
				function()
					neogen.generate({ type = "func" })
				end,
				desc = "Document Function",
			},
		}
	end,
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
