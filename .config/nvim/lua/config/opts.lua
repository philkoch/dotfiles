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
vim.opt.title = true
vim.opt.titlestring = "  " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
