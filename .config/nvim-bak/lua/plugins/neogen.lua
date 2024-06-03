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

		-- keymappings
		local wk = require("which-key")
		wk.register({
			r = {
				name = " NEOGEN",
				c = {
					"<cmd>lua require('neogen').generate({ type = 'class' })<CR>",
					"Document Class",
					noremap = true,
					silent = true,
				},
				f = {
					"<cmd>lua require('neogen').generate({ type = 'func' })<CR>",
					"Document Function",
					noremap = true,
					silent = true,
				},
			},
		}, { prefix = "<leader>" })
		wk.setup()
	end,
}
