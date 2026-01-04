return {
	"neovim/nvim-lspconfig",
	lazy = true,
	priority = 500,
	---@class PluginLspOpts
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},
	ft = { "python", "rust", "lua", "markdown", "txt", "toml", "json" },

	opts = {
		servers = {
			pyright = {
				root_markers = { "pyproject.toml", "poetry.lock", ".git" },

				-- Statt on_new_config: auf "attach" sicher aktualisieren
				on_attach = function(client, bufnr)
					if client.name ~= "pyright" then
						return
					end

					local utils = require("utils")
					local function pj(a, b)
						return a .. "/" .. b
					end

					-- 1) Poetry-venv suchen (deine Funktion), dann .venv als Fallback
					local venv = utils.get_poetry_venv()
					if not venv and vim.fn.isdirectory(".venv") == 1 then
						venv = vim.fn.fnamemodify(".venv", ":p")
					end

					-- 2) Interpreter wählen
					local python
					if venv and venv ~= "" then
						local candidate = pj(venv, "bin/python")
						if vim.fn.executable(candidate) == 1 then
							python = candidate
							-- Environment angleichen (auch für ruff/black usw.)
							vim.env.VIRTUAL_ENV = venv
							vim.env.PATH = pj(venv, "bin") .. ":" .. vim.env.PATH
							vim.notify("Pyright: using poetry venv python: " .. python, vim.log.levels.INFO)
						end
					end
					if not python or python == "" then
						local exepath = vim.fn.exepath("python3")
						if exepath ~= "" and vim.fn.executable(exepath) == 1 then
							python = exepath
							vim.notify("Pyright: using PATH python: " .. python, vim.log.levels.INFO)
						else
							vim.notify("Pyright: no valid python found!", vim.log.levels.ERROR)
							return
						end
					end

					-- 3) Settings live setzen + an den Server schicken
					client.config.settings = client.config.settings or {}
					client.config.settings.python = client.config.settings.python or {}
					client.config.settings.python.pythonPath = python
					client.config.settings.python.analysis =
						vim.tbl_deep_extend("force", client.config.settings.python.analysis or {}, {
							autoSearchPaths = true,
							diagnosticMode = "workspace", -- Monorepo-freundlich
							useLibraryCodeForTypes = true,
							extraPaths = { "src" }, -- falls ihr src/ nutzt
						})

					-- -> Pyright bekommt die neuen Settings
					client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
				end,
			},
		},
	},

	config = function(_, opts)
		require("mason").setup()
		-- Config registrieren, dann enable (oder mason-lspconfig auto-enable nutzen)
		vim.lsp.config("pyright", opts.servers.pyright)
		vim.lsp.enable("pyright")
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
