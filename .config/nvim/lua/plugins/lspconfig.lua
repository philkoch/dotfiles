return {
	"neovim/nvim-lspconfig",
	lazy = true,
	---@class PluginLspOpts
	dependencies = {
		{ "williamboman/mason.nvim", lazy = "VeryLazy" },
		{ "williamboman/mason-lspconfig.nvim", lazy = "VeryLazy" },
		{ "saghen/blink.cmp" },
	},
	ft = { "python", "rust", "lua", "markdown", "txt" },
	opts = {
		---@type lspconfig.options
		servers = {
			pyright = {
				-- look for poetry.lock-file and set the correct venv in
				-- neovim to make pyright behave correctly without calling
				-- poetry shell before opening neovim
				on_new_config = function(config, root_dir)
					local cur_venv = vim.env.VIRTUAL_ENV or ""
					if cur_venv == "" then
						local venv_path = require("utils").get_poetry_venv() or "error"
						if venv_path then
							vim.env.VIRTUAL_ENV = venv_path
							vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH
							vim.env.PYTHONPATH = vim.fn.getcwd()
							config.settings.python.pythonPath = venv_path .. "/bin/python"
						end
					end
				end,
			},
		},
	},
	config = function(_, opts)
		require("mason").setup()
		local lspconfig = require("lspconfig")
		for server, config in pairs(opts.servers) do
			-- passing config.capabilities to blink.cmp merges with the capabilities in your
			-- `opts[server].capabilities, if you've defined it
			-- TODO: once nvim is on 0.11+, this is not required anymore
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			lspconfig[server].setup(config)
		end
	end,
	keys = {
		{
			"gl",
			function()
				vim.diagnostic.open_float()
			end,
			desc = "   Show Diagnostic",
		},
		{
			"<leader>ln",
			function()
				vim.diagnostic.goto_next()
			end,
			desc = "󰒭   Next Diagnostic",
		},
		{
			"<leader>lp",
			function()
				vim.diagnostic.goto_prev()
			end,
			desc = "󰒮   Previous Diagnostic",
		},
		{
			"<leader>lq",
			function()
				vim.lsp.buf.hover()
			end,
			desc = "󰠢   Show hover information",
		},
		{
			"<leader>la",
			function()
				vim.lsp.buf.code_action()
			end,
			desc = "   Code Action",
		},
		{
			"<leader>lm",
			function()
				vim.lsp.buf.rename()
			end,
			desc = "   Rename",
		},
		{
			"<leader>ls",
			function()
				vim.lsp.buf.signature_help()
			end,
			desc = "󰮥   Signature Help",
		},
	},
}
