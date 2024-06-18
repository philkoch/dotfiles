return {
	{
		"echasnovski/mini.nvim",
		lazy = false,
		config = function()
			local animate = require("mini.animate")
			animate.setup({
				cursor = {
					enable = false,
					timing = animate.gen_timing.linear({ duration = 30, unit = "total" }),
				},
				scroll = {
					enable = false,
					timing = animate.gen_timing.linear({ duration = 40, unit = "total" }),
				},
				resize = {
					timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
				},
			})
			require("mini.surround").setup()
			require("mini.sessions").setup({
				-- Whether to read latest session if Neovim opened without file arguments
				autoread = true,
				-- Whether to write current session before quitting Neovim
				autowrite = true,
				-- Directory where global sessions are stored (use `''` to disable)
				-- directory = "session",
			})
		end,
	},
}
