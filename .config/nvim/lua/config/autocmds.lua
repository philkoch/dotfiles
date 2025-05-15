-- AUTOCOMMANDS >>>>>>>>

-- open :help in vertical split
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = vim.api.nvim_create_augroup("help_window_right", { clear = true }),
	pattern = { "*.txt" },
	callback = function()
		if vim.o.filetype == "help" then
			vim.cmd.wincmd("L")
		end
	end,
})

-- highlighted yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

-- 2-space-tabs in markdown files to be in-line with the linter
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	group = vim.api.nvim_create_augroup("MarkdownTabWidth", { clear = true }),
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
	end,
})
