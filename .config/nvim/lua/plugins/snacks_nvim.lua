return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		animate = { enabled = false },
		bigfile = { enabled = true },
		bufdelete = { enabled = true },
		dashboard = { enabled = false },
		debug = { enabled = false },
		dim = { enabled = true },
		git = { enabled = true },
		gitbrowse = { enable = false },
		indent = { enabled = true },
		input = { enabled = true },
		layout = { enabled = false },
		lazygit = { enabled = true },
		notifier = { enabled = true },
		picker = { enabled = true },
		quickfile = { enabled = true },
		rename = { enabled = false },
		scope = { enabled = false },
		scratch = { enabled = false },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		terminal = { enabled = false },
		toggle = { enabled = false },
		win = { enabled = false },
		words = { enabled = true },
		zen = { enabled = false },
	},
	keys = {
        -- stylua: ignore start	
        -- buffers
		{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer", },
		{ "<leader>ba", function() Snacks.bufdelete.all() end, desc = "Delete all Buffers", },
		-- git
		{ "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line", },
		{ "<leader>gg", function() Snacks.lazygit.open() end, desc = "LazyGit", },
		{ "<leader>gc", function() Snacks.picker.git_log() end, desc = "Git Log", },
		{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status", },
		-- picker
        -- buffers
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>ft", function() Snacks.picker.grep() end, desc = "Grep Text" },
		{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
		{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
		{ "<leader>fh", function() Snacks.picker.help() end, desc = "Find Git Files" },
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
        -- LSP
		{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Go to definitions" },
		{ "gr", function() Snacks.picker.lsp_references() end, desc = "Show References" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Go to Implementation" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Go to Type Definition" },
        { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
		--
		-- stylua: ignore end

		-- run just command-runner - https://github.com/casey/just
		-- TODO: close terminal when just finishes with code 0
		{
			"<leader>rj",
			function()
				if vim.fn.executable("just") == 0 then
					vim.notify("Fehler: 'just' ist nicht installiert oder nicht im $PATH.", vim.log.levels.ERROR)
					return
				end

				-- 2. just --summary aufrufen und Ausgabe auslesen
				local handle = io.popen("just --summary 2>/dev/null")
				local summary = handle and handle:read("*a") or ""
				if handle then
					handle:close()
				end

				-- 3. Die Ausgabe splitten (Rezepte liegen i.d.R. in einer einzelnen Zeile, getrennt durch Leerzeichen)
				local recipes = {}
				for recipe in summary:gmatch("%S+") do
					table.insert(recipes, recipe)
				end

				if #recipes == 0 then
					vim.notify("Keine Just-Rezepte gefunden (just --summary gab nichts zurück).", vim.log.levels.ERROR)
					return
				end

				-- 4. Snacks-Picker öffnen und Rezept auswählen lassen
				Snacks.picker.select(
					recipes, -- die Rezepte
					{
						prompt = "Pick a just-recipe", -- optionaler Prompt
					},
					function(choice)
						if not choice then
							-- abgebrochen oder nichts ausgewählt
							return
						end
						-- 5. Terminal-Split öffnen und das Rezept ausführen
						vim.cmd("split | terminal just " .. choice)
						-- Optional, um direkt im Terminal zu sein: vim.cmd("startinsert")
					end
				)
			end,
			desc = "Run just-recipe",
		},
	},
}
