-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/mfussenegger/nvim-dap-python
-- https://github.com/rcarriga/nvim-dap-ui

return {
	"mfussenegger/nvim-dap-python",
	dependencies = { "mfussenegger/nvim-dap" },
	lazy = false,
	config = function()
		-- stop on exception
		-- require("dap").defaults.fallback.exception_breakpoints = { "raised" }
		-- allow switching of buffers on step-into action
		require("dap").defaults.fallback.switchbuf = "usetab,uselast"
		local dap_py = require("dap-python")
		dap_py.setup("~/.config/nvim/.virtualenvs/debugpy/bin/python")
		dap_py.test_runner = "pytest"

		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "󱡴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapBreakpointRejected",
			{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapLogPoint",
			{ text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
		)
		vim.fn.sign_define(
			"DapStopped",
			{ text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
		)
		--
		-- https://github.com/rcarriga/nvim-dap-ui
		local dap, dapui = require("dap"), require("dapui")
		dapui.setup()

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,
}
