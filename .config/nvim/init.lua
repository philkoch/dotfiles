-- load opts, keymaps, autocmds and custom functions
require("config.opts")
require("config.keys")
require("config.autocmds")
require("config.functions")

-- pretty in-line diagnostics
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

-- PLUGINS >>>>>>>>

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", { defaults = { lazy = false } })

-- COLORSCHEME >>>>>>>
--
-- set colorscheme AFTER loading plugins
vim.cmd.colorscheme("kanagawa-wave")
