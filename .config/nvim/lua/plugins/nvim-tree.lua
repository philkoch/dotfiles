return {
	"nvim-tree/nvim-tree.lua",
	name = "nvim-tree",
	-- priority = 1000,
	-- lazy = false,
	requires = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{
			"<leader>e",
			function()
				local api = require("nvim-tree.api")
				api.tree.toggle()
			end,
			mode = "n",
			desc = "Directory Tree",
		},
	},
	config = function()
		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			view = {
				width = 30,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = true,
			},
		})
	end,
}
