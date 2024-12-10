-- config for lsp-zero<https://github.com/VonHeikemen/lsp-zero.nvim>
return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v1.x",
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "hrsh7th/nvim-cmp" },
		{ "onsails/lspkind.nvim" },

		-- lsp-colors
		"folke/lsp-colors.nvim",
	},
	config = function()
		local lsp = require("lsp-zero")

		lsp.preset("recommended")
		lsp.ensure_installed({
			"rust_analyzer",
			"pyright",
		})

		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		local cmp_compare = cmp.config.compare
		local cmp_mappings = lsp.defaults.cmp_mappings({
			["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
			["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
			["<C-y>"] = cmp.mapping.confirm({ select = true }),
			["<C-Space>"] = cmp.mapping.complete(),
			["<Tab>"] = vim.NIL,
			["<S-Tab>"] = vim.NIL,
			["<Enter>"] = vim.NIL,
		})

		-- required for formatting of nvim-cmp
		local lspkind = require("lspkind")

		lsp.setup_nvim_cmp({
			enabled = function()
				-- disable completion in comments
				local context = require("cmp.config.context")
				-- keep command mode completion enabled when cursor is in a comment
				if vim.api.nvim_get_mode().mode == "c" then
					return true
				else
					return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
				end
			end,
			preselect = "none",
			completion = {
				completeopt = "menu,menuone,noinsert,noselect",
			},
			mapping = cmp_mappings,
			sources = cmp.config.sources({
				{ name = "path", keyword_length = 3 },
				{
					name = "nvim_lsp",
					-- Dont suggest Text from nvim_lsp
					-- entry_filter = function(entry, ctx)
					-- 	return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind()
					-- end,
					keyword_length = 2,
				},
				{ name = "buffer", keyword_length = 4 },
				{ name = "luasnip", keyword_length = 2 },
				{ name = "nvim_lua", keyword_length = 2 },
			}, {}),
			sorting = {
				priority_weight = 2,
				comparators = {
					cmp_compare.offset,
					cmp_compare.exact,
					cmp_compare.score,
					-- function should sort propositions starting with underscores at
					-- the end of the list instead of the beginning,
					-- taken from https://github.com/tjdevries/config_manager/blob/83b6897e83525efdfdc24001453137c40373aa00/xdg_config/nvim/after/plugin/completion.lua#L129-L155
					function(entry1, entry2)
						local _, entry1_under = entry1.completion_item.label:find("^__")
						local _, entry2_under = entry2.completion_item.label:find("^__")
						entry1_under = entry1_under or 0
						entry2_under = entry2_under or 0
						if entry1_under > entry2_under then
							return false
						elseif entry1_under <= entry2_under then
							return true
						end
					end,
					cmp_compare.recently_used,
					cmp_compare.locality,
					cmp_compare.order,
					-- cmp_compare.kind,
					-- cmp_compare.length,
				},
			},
			formatting = {
				format = lspkind.cmp_format({
					preset = "default",
					mode = "symbol",
					ellipsis_char = "...",
					menu = {
						buffer = "[buf]",
						nvim_lsp = "[lsp]",
						nvim_lua = "[lua]",
						path = "[path]",
						luasnip = "[snp]",
						cmdline = "[cmd]",
					},
				}),
			},
			experimental = {
				native_menu = false,
			},
		})

		lsp.on_attach(function(client, bufnr)
			local opts = { buffer = bufnr, remap = false }
			vim.keymap.set("n", "gd", function()
				require("telescope.builtin").lsp_definitions()
			end, opts)
			vim.keymap.set("n", "gl", function()
				vim.diagnostic.open_float()
			end, opts)
			vim.keymap.set("n", "<leader>lq", function()
				vim.lsp.buf.hover()
			end, opts)
			vim.keymap.set("n", "<leader>ld", function()
				require("telescope.builtin").diagnostics({ bufnr = bufnr })
			end, opts)
			vim.keymap.set("n", "<leader>ln", function()
				vim.diagnostic.goto_next()
			end, opts)
			vim.keymap.set("n", "<leader>lp", function()
				vim.diagnostic.goto_prev()
			end, opts)
			vim.keymap.set("n", "<leader>la", function()
				vim.lsp.buf.code_action()
			end, opts)
			vim.keymap.set("n", "<leader>lr", function()
				require("telescope.builtin").lsp_references()
			end, opts)
			vim.keymap.set("n", "<leader>lm", function()
				vim.lsp.buf.rename()
			end, opts)
			vim.keymap.set("n", "<leader>ls", function()
				vim.lsp.buf.signature_help()
			end, opts)
		end)

		-- (Optional) Configure lua language server for neovim
		lsp.nvim_workspace()

		lsp.configure("pyright", {
			-- look for poetry-lock file and set the correct venv in
			-- neovim to make pyright behave correctly without calling
			-- poetry shell before opening neovim
			on_new_config = function(config, root_dir)
				local match = vim.fn.glob(vim.fn.getcwd() .. "/poetry.lock")
				local cur_venv = vim.env.VIRTUAL_ENV
				if match ~= "" and cur_venv == nil or cur_venv == "" then
					-- current poetry version prints out errors in addition to the path
					-- when the pyproject toml contains deprecated definitions.
					-- the warnings are removed here
					local poetry_env_output_with_warnings = vim.fn.trim(vim.fn.system("poetry env info -p"))
					local lines = vim.fn.split(poetry_env_output_with_warnings, "\n")
					local venv_path = lines[#lines]
					vim.env.VIRTUAL_ENV = venv_path
					vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH
					-- set pythonpath for pytest/neotest
					vim.env.PYTHONPATH = vim.fn.getcwd()
					config.settings.python.pythonPath = venv_path .. "/bin/python"
					print(vim.env.VIRTUAL_ENV)
				end
			end,
		})

		lsp.setup()

		-- enables in-line diagnostics
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = false,
			update_in_insert = false,
			severity_sort = true,
		})
		-- set pretty diagnostics-signs in signcolumn
		vim.fn.sign_define("DiagnosticSignError", { text = "" })
		vim.fn.sign_define("DiagnosticSignWarn", { text = "" })
		vim.fn.sign_define("DiagnosticSignInfo", { text = "" })
		vim.fn.sign_define("DiagnosticSignHint", { text = "" })
	end,
}
