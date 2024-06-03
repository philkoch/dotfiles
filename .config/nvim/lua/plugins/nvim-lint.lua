return {
	"mfussenegger/nvim-lint",
	lazy = false,
	config = function()
		require("lint").linters_by_ft = {
			markdown = { "vale" },
			python = { "ruff", "mypy" },
			lua = { "luacheck" },
			json = { "jsonlint" },
			js = { "eslint" },
		}

		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = "*",
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
