-- OPTIONS >>>>>>>>
--
-- disable netrw because of possible problems with nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
-- set leader key to <Space>
vim.g.mapleader = " "

-- line numbers
vim.opt.nu = true

-- relative line numbers
vim.opt.relativenumber = true
--
-- set tabs to 4 spaces instead of 8
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- convert tabs to spaces
vim.opt.expandtab = true

-- highlight cursor position
vim.opt.cursorline = true

-- does smart autoindenting when starting a new line
vim.opt.autoindent = true
vim.opt.smartindent = true

-- prevents wrapping of long lines
vim.opt.wrap = false

-- don't create a swapfile
vim.opt.swapfile = false

-- better undos (the plugin `undotree` is also used)
vim.opt.undodir = os.getenv("HOME") .. "/.config/.nvim/undo"
vim.opt.undofile = true

-- start searching while typing and
-- highlight results
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
-- case-sensitive search when using uppercase letters,
-- case-insensitive otherwise
vim.opt.smartcase = true

-- minimum number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 8

-- number of columns the screen is moved when the cursor would leave it
vim.opt.sidescroll = 1
-- minimum number of columns to keep visible when scrolling horizontally
vim.opt.sidescrolloff = 16

-- adds a column next to the line numbers holding symbols
-- for diagnostics or information like if a breakpoint is
-- on that line
vim.opt.signcolumn = "yes"

-- colored column indicating preferred max line length
vim.opt.colorcolumn = "88"

-- disables displaying of mode (this is done by lualine)
vim.opt.showmode = false

-- hide commandline when it's not used
vim.opt.cmdheight = 0

-- checks if buffer is already loaded and if so
-- opens it in that window
vim.opt.swb = "useopen"

-- limit elements in pop-up windows to 8 (e.g. nvim-cmp)
vim.opt.pumheight = 8

-- open vertical split windows to the right
vim.opt.splitright = true

-- open horizontal split down
vim.opt.splitbelow = true

-- use system clipboard as default
vim.opt.clipboard = "unnamedplus"

-- see :h shortmess for options
vim.opt.shortmess = "filmxstToOF"

-- treeview in netrw
vim.g.netrw_liststyle = 3

-- use indent-fold method
-- vim.opt.foldmethod = "indent"

-- KEY MAPPINGS >>>>>>>>

-- netrw file explorer
-- vim.api.nvim_set_keymap("n", "<leader>e", ":Lexplore<CR> :vertical resize 30<CR>", { noremap = true })

-- moves selected lines up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keeps cursor in the middle of the screen
-- when jumping half pages up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- search results stay in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- easier indent in visualmode
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- move cursor between buffers
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- easier buffer resizing
vim.keymap.set("n", "<C-Up>", "<C-W>+")
vim.keymap.set("n", "<C-Down>", "<C-W>-")
vim.keymap.set("n", "<C-Left>", "<c-w>5<")
vim.keymap.set("n", "<C-Right>", "<c-w>5>")

-- remove highlighting
vim.keymap.set("n", "<leader>h", "<cmd>noh<CR>", { desc = "󰉅   No Highlight" })

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
--
-- AUTOCOMMANDS >>>>>>>>

-- open :help in vertical split
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = vim.api.nvim_create_augroup("help_window_right", {}),
	pattern = { "*.txt" },
	callback = function()
		if vim.o.filetype == "help" then
			vim.cmd.wincmd("L")
		end
	end,
})

-- highlighted yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

-- USER FUNCTIONS >>>>>>>>>>

local function clean_urls()
	-- removes http/https protocol, www., query parameters and trailing slashes
	local substitutions = {
		{ "http:\\/\\/", "" },
		{ "https:\\/\\/", "" },
		{ "\\r", "" },
		{ "www\\.", "" },
		{ "?.*", "" },
		{ "\\/$", "" },
	}

	local buf = vim.api.nvim_get_current_buf()

	for _, sub in ipairs(substitutions) do
		local search = sub[1]
		local replace = sub[2]
		pcall(function()
			vim.api.nvim_buf_call(buf, function()
				vim.cmd(string.format("%%s/%s/%s/g", search, replace))
			end)
		end)
	end
end

-- Expose the function as a command
vim.api.nvim_create_user_command("CleanURLs", clean_urls, {})

local function add_quotes()
	local buf = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

	for i, line in ipairs(lines) do
		if i == #lines then
			lines[i] = '"' .. line .. '"'
		else
			lines[i] = '"' .. line .. '",'
		end
	end
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

-- Create a command to call the function
vim.api.nvim_create_user_command("AddQuotes", add_quotes, {})

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
-- set colorscheme AFTER loading plugins
-- vim.cmd.colorscheme("catppuccin")
-- vim.cmd.colorscheme("tokyonight-night")
-- vim.cmd.colorscheme("eldritch")
vim.cmd.colorscheme("kanagawa-wave")

-- highlights the current line number
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#f9e2af", bg = "#33313a", bold = true })
-- color of line the debugger is on
vim.api.nvim_set_hl(0, "debugPC", { fg = "#f9e2af", bg = "#33313a", bold = true })

-- highlights for indent-blankline plugin
vim.opt.termguicolors = true
vim.opt.list = true

vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = "#E06C75", nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", { fg = "#E5C07B", nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineIndent3", { fg = "#98C379", nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineIndent4", { fg = "#56B6C2", nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineIndent5", { fg = "#61AFEF", nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineIndent6", { fg = "#C678DD", nocombine = true })
