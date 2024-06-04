return {
	{
		"echasnovski/mini.nvim",
		config = function()
			local animate = require("mini.animate")
			animate.setup({
				cursor = {
					timing = animate.gen_timing.linear({ duration = 30, unit = "total" }),
				},
				scroll = {
					timing = animate.gen_timing.linear({ duration = 40, unit = "total" }),
				},
				resize = {
					timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
				},
			})
			require("mini.surround").setup()
		end,
	},
}
