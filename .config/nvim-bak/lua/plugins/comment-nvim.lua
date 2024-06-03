-- https://github.com/numToStr/Comment.nvim

return {
	"numToStr/Comment.nvim",
	lazy = false,
	config = function()
		local utils = require("Comment.utils")

		require("Comment").setup({
			post_hook = function(ctx)
				-- Check whether we were in VISUAL mode
				if ctx.cmotion == utils.cmotion.v or ctx.cmotion == utils.cmotion.V then
					vim.cmd("norm! gv")
				end
			end,
			toggler = {
				---Line-comment toggle keymap
				line = "gcc",
				---Block-comment toggle keymap
				block = "gbc",
			},
		})
	end,
}
