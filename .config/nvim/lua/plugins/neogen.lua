return {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	version = "*",
	lazy = true,
	config = function()
		require("neogen").setup({
			snippet_engine = "luasnip",
			languages = {
				python = {
					["python.reST"] = require("neogen.configurations.python"),
				},
			},
		})
	end,
}
