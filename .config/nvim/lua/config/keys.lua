-- KEY MAPPINGS >>>>>>>>

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

-- tab handling
vim.keymap.set("n", "<leader>Tn", "<cmd>tabnext<CR>", { desc = "󰮱  Next tab" })
vim.keymap.set("n", "<leader>Tp", "<cmd>tabprevious<CR>", { desc = "󰮳  Previous tab" })
vim.keymap.set("n", "<leader>Tc", "<cmd>tabclose<CR>", { desc = "  Close tab" })

-- no autocommands on save with `:W`, useful to store file without formatting
vim.api.nvim_create_user_command("W", function()
	vim.cmd("noautocmd write")
end, {})
