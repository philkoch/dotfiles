-- TODO: add function to add value under cursor to watches
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{ "mfussenegger/nvim-dap-python", lazy = true },
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	lazy = true,
	keys = function()
		return {
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "   Launch / Continue",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "   Step Over",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "   Step Into",
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "   Step Out",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "   Toggle Breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap-python").test_class({ config = { justMyCode = false } })
				end,
				desc = "   Test Class",
			},
			{
				"<leader>dm",
				function()
					require("dap-python").test_method({ config = { justMyCode = false } })
				end,
				desc = "   Test Method",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "   Run Last Session",
			},
			{
				"<leader>dp",
				function()
					require("dap").repl.open()
				end,
				desc = "   Open REPL",
			},
			{
				"<leader>dr",
				function()
					require("dap").restart()
				end,
				desc = "󱄌   Restart Session",
			},
			{
				"<leader>dx",
				function()
					require("dap").terminate()
				end,
				desc = "   Stop",
			},
			{
				"<leader>dB",
				function()
					vim.ui.input({
						prompt = "Enter condition:",
					}, function(input)
						if input ~= nil then
							require("dap").toggle_breakpoint(input)
						end
					end)
				end,
				desc = "   Conditional Breakpoint",
			},
			{
				"<leader>de",
				function()
					require("dapui").eval(nil, { enter = true })
				end,
				desc = "   Eval under cursor",
			},
		}
	end,
	config = function()
		-- allow switching of buffers on step-into action
		dap = require("dap")
		dap.defaults.fallback.switchbuf = "usetab,uselast"
		-- use directory where pyproject.toml is found as cwd instead of directory
		-- of file
		local dap_py = require("dap-python")
		dap_py.setup("~/.config/nvim/.virtualenvs/debugpy/bin/python", {})
		dap_py.test_runner = "pytest"

		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "debugBreakpoint", linehl = "debugBreakpoint" })
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "󰙠", texthl = "debugBreakpoint", linehl = "debugBreakpoint" }
		)
		vim.fn.sign_define(
			"DapBreakpointRejected",
			{ text = "", texthl = "debugBreakpointRej", linehl = "debugBreakpointRej" }
		)
		vim.fn.sign_define(
			"DapLogPoint",
			{ text = "", texthl = "debugLogPoint", linehl = "debugLogPoint", numhl = "debugLogPoint" }
		)
		vim.fn.sign_define(
			"DapStopped",
			{ text = "", texthl = "debugStopped", linehl = "debugStopped", numhl = "debugStopped" }
		)
		--
		-- https://github.com/rcarriga/nvim-dap-ui
		local dap, dapui = require("dap"), require("dapui")
		dapui.setup()

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.after.event_attached["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		table.insert(dap.configurations.python, 1, {
			type = "python",
			request = "launch",
			name = "Debug Python",
			program = "${file}",
			console = "integratedTerminal",
			justMyCode = false,
			cwd = function()
				return vim.fn.getcwd()
			end,
		})
	end,
}
