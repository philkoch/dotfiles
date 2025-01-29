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
			local miniclue = require("mini.clue")
			miniclue.setup({
				triggers = {
					-- Leader triggers
					{ mode = "n", keys = "<Leader>" },
					{ mode = "x", keys = "<Leader>" },

					-- Built-in completion
					{ mode = "i", keys = "<C-x>" },

					-- `g` key
					{ mode = "n", keys = "g" },
					{ mode = "x", keys = "g" },

					-- Marks
					{ mode = "n", keys = "'" },
					{ mode = "n", keys = "`" },
					{ mode = "x", keys = "'" },
					{ mode = "x", keys = "`" },

					-- Registers
					{ mode = "n", keys = '"' },
					{ mode = "x", keys = '"' },
					{ mode = "i", keys = "<C-r>" },
					{ mode = "c", keys = "<C-r>" },

					-- Window commands
					{ mode = "n", keys = "<C-w>" },

					-- `z` key
					{ mode = "n", keys = "z" },
					{ mode = "x", keys = "z" },
				},

				clues = {
					-- Enhance this by adding descriptions for <Leader> mapping groups
					miniclue.gen_clues.builtin_completion(),
					miniclue.gen_clues.g(),
					miniclue.gen_clues.marks(),
					miniclue.gen_clues.registers(),
					miniclue.gen_clues.windows(),
					miniclue.gen_clues.z(),
				},
			})
			require("mini.sessions").setup({
				-- Whether to read latest session if Neovim opened without file arguments
				autoread = false,
				-- Whether to write current session before quitting Neovim
				autowrite = true,
				-- Directory where global sessions are stored (use `''` to disable)
				-- directory = "session",
			})
		end,
	},
}
