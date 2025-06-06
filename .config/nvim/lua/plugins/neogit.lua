return {
	"NeogitOrg/neogit",
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		-- Only one of these is needed.
		-- "nvim-telescope/telescope.nvim", -- optional
		-- snacks-picker?? -> https://github.com/NeogitOrg/neogit/issues/1663
		"ibhagwan/fzf-lua", -- optional
		-- "echasnovski/mini.pick", -- optional
	},
	config = function()
		require("neogit").setup({
			commit_editor = {
				kind = "vsplit", -- open commit-window in vertical split
			},
			integations = {
				diffview = true,
			},
		})
	end,
	keys = {
		{
			"<leader>gs",
			"<cmd>Neogit<CR>",
			mode = "n",
			desc = "  Neogit",
		},
	},
}
