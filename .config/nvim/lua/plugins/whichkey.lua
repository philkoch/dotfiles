-- https://github.com/folke/which-key.nvim
-- popup that displays possible key combinations on <leader>
return {
	"folke/which-key.nvim",
	lazy = false,
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		local wk = require("which-key")
		-- telescope keymaps
		local telescope_builtin = require("telescope.builtin")
		wk.add({
			{ "<leader>f", group = "FIND" },
			{ "<leader>fb", telescope_builtin.buffers, desc = "Find Buffer" },
			{ "<leader>fc", telescope_builtin.command_history, desc = "Find Command" },
			{ "<leader>fe", telescope_builtin.oldfiles, desc = "Find Recent File" },
			{ "<leader>ff", telescope_builtin.find_files, desc = "Find File" },
			{ "<leader>fh", telescope_builtin.help_tags, desc = "Find Help" },
			{ "<leader>fj", telescope_builtin.jumplist, desc = "Find Jump" },
			{ "<leader>fl", telescope_builtin.pickers, desc = "Last Pickers" },
			{ "<leader>fq", telescope_builtin.quickfix, desc = "Find QuickFix" },
			{ "<leader>fr", telescope_builtin.resume, desc = "Resume Results" },
			{ "<leader>ft", telescope_builtin.live_grep, desc = "Find Text" },
		})

		-- mason keymaps
		wk.add({
			{ "<leader>m", group = "MASON" },
			{ "<leader>mi", "<cmd>MasonInstall ", desc = "Install..." },
			{ "<leader>ml", "<cmd>MasonLog ", desc = "Log" },
			{ "<leader>mo", "<cmd>Mason<CR>", desc = "Open" },
			{ "<leader>mu", "<cmd>MasonUninstall ", desc = "Uninstall..." },
		})

		-- Lsp keymaps
		local neogen = require("neogen")
		wk.add({
			{ "<leader>l", group = "LSP" },
			{ "<leader>lR", "<cmd>LspRestart<CR>", desc = "Restart LSP" },
			{ "<leader>la", desc = "Code action" },
			{ "<leader>ld", desc = "Open Diagnostic" },
			{ "<leader>lm", desc = "Rename" },
			{ "<leader>ln", desc = "Next Diagnostic" },
			{ "<leader>lo", "<cmd>AerialToggle<CR>", desc = "Outline" },
			{ "<leader>lp", desc = "Previous Diagnostic" },
			{ "<leader>lq", desc = "Quick Documentation" },
			{ "<leader>lr", desc = "References" },
			{ "<leader>ls", desc = "Signature Help" },
			{
				"<leader>lcc",
				function()
					neogen.generate({ type = "class" })
				end,
				desc = "Document Class",
			},
			{
				"<leader>lcf",
				function()
					neogen.generate({ type = "func" })
				end,
				desc = "Document Class",
			},
		})

		-- others
		local gitsigns = require("gitsigns")
		wk.add({
			{ "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = " EXPLORER" },
			{ "<leader>g", group = " GIT" },
			{ "<leader>gg", "<cmd>LazyGit<CR>", desc = "lazygit" },
			{ "<leader>gb", gitsigns.blame_line, desc = "Blame Line" },
			{ "<leader>h", "<cmd>noh<CR>", desc = " NO HIGHLIGHT" },
			{ "<leader>u", desc = "UNDOTREE" },
			{ "<leader>x", desc = "TROUBLE TOGGLE" },
			{
				"<leader>y",
				function()
					if require("peek").is_open() then
						require("peek").close()
					else
						require("peek").open()
					end
				end,
				desc = " .MD PREVIEW",
			},
		})

		-- debugger
		local dap = require("dap")
		local dap_py = require("dap-python")
		wk.add({
			{ "<leader>d", group = "DEBUG" },
			{
				"<leader>db",
				function()
					dap.toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dc",
				function()
					dap_py.test_class({ config = { justMyCode = false } })
				end,
				desc = "Test Class",
			},
			{
				"<leader>dl",
				function()
					dap.run_last()
				end,
				desc = "Run Last Session",
			},
			{
				"<leader>dm",
				function()
					dap_py.test_method({ config = { justMyCode = false } })
				end,
				desc = "Test Method",
			},
			{
				"<leader>dp",
				function()
					dap.repl.open()
				end,
				desc = "Open REPL",
			},
			{
				"<leader>dr",
				function()
					dap.restart()
				end,
				desc = "Restart Session",
			},
			{
				"<leader>dx",
				function()
					dap.terminate()
				end,
				desc = "Stop",
			},
			{
				"<leader>dB",
				function()
					vim.ui.input({
						prompt = "Enter condition:",
					}, function(input)
						if input ~= nil then
							dap.toggle_breakpoint(input)
						end
					end)
				end,
				desc = "Conditional Breakpoint",
			},
		})

		wk.add({
			{
				"<F5>",
				function()
					dap.continue()
				end,
				desc = "Launch / Continue",
			},
			{
				"<F10>",
				function()
					dap.step_over()
				end,
				desc = "Step Over",
			},
			{
				"<F11>",
				function()
					dap.step_into()
				end,
				desc = "Step Into",
			},
			{
				"<F12>",
				function()
					dap.step_out()
				end,
				desc = "Step Out",
			},
		})

		-- test-suite
		local neotest = require("neotest")
		wk.add({
			{ "<leader>t", group = "TEST" },
			{
				"<leader>tf",
				function()
					neotest.run.run(vim.fn.expand("%"))
					neotest.summary.open()
				end,
				desc = "Test current file",
			},
			{
				"<leader>tl",
				function()
					neotest.run.run_last()
				end,
				desc = "Run last configuration",
			},
			{
				"<leader>to",
				function()
					neotest.output_panel.toggle()
				end,
				desc = "Toggle test output",
			},
			{
				"<leader>ts",
				function()
					neotest.summary.toggle()
				end,
				desc = "Toggle test summary",
			},
			{
				"<leader>tt",
				function()
					neotest.run.run()
					neotest.summary.open()
				end,
				desc = "Run nearest test",
			},
			{
				"<leader>tx",
				function()
					neotest.run.stop()
				end,
				desc = "Stop test run",
			},
		})

		-- refactoring.nvim
		wk.add({
			{ "<leader>r", desc = " REFACTOR" },
			{ "<leader>re", desc = "Extract" },
			{ "<leader>rf", desc = "Function" },
			{ "<leader>rv", desc = "Variable" },
		})

		wk.setup()
	end,
}
