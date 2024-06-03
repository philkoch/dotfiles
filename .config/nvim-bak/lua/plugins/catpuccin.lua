-- https://github.com/catppuccin/nvim
-- colortheme
return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			dim_inactive = {
				enabled = true,
				shade = "dark",
				percentage = 0.01,
			},
			integrations = {
				cmp = true,
				which_key = true,
				telescope = true,
			},
		})
	end,
}
