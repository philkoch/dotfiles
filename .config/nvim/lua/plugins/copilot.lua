-- https://github.com/zbirenbaum/copilot.lua
-- https://github.com/zbirenbaum/copilot-cmp
return {
	"zbirenbaum/copilot.lua",
	lazy = true,
	dependencies = {
		{ "zbirenbaum/copilot-cmp" },
	},
	config = function()
		require("copilot").setup({
			suggestion = {
				keymap = {
					accept = "<C-Y>",
				},
				auto_trigger = true,
				-- suggestions should be disabled when using copilot-cmp
				enabled = false,
			},
			-- panel should be disabled when using copilot-cmp
			panel = { enabled = false },
		})
		-- load copilot-cmp plugin
		require("copilot_cmp").setup()
	end,
}
