return {
	"zbirenbaum/copilot.lua",
	lazy = true,
	config = function()
		require("copilot").setup({
			suggestion = {
				keymap = {
					accept = "<C-Y>",
				},
				auto_trigger = true,
			},
		})
	end,
}
