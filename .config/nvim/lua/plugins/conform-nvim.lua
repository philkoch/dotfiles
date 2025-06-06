return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>bf",
			function()
				require("conform").format({ async = true })
			end,
			desc = "󰗈   Format buffer",
		},
	},
	ft = { "lua", "python", "js", "markdown", "json", "just", "xml" },
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "ruff_format" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			md = { "mdformat" },
			json = { "jq" },
			just = { "just" },
			xml = { "xmlformatter" },
			toml = { "taplo" },
			rust = { "rustfmt" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		-- Set up format-on-save
		format_on_save = { timeout_ms = 500 },
		-- Customize formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
		},
	},
	-- init = function()
	-- 	-- If you want the formatexpr, here is the place to set it
	-- 	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	-- end,
}
