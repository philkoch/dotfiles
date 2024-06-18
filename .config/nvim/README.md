# NVIM-CONFIG

My nvim-config based on [0 to LSP: Neovim RC From Scratch](https://www.youtube.com/watch?v=w7i4amO_zaE) from [ThePrimagen](https://github.com/ThePrimeagen).
To use the configuration you need to copy the folder into your neovim-configuration folder (default: `~/.config/nvim`), start
up neovim, run `:Lazy` and check the config for `post-install` sections for the plugins.

> Check `./lua/plugins` for configurations of each plugin

The following plugins are used:

| Plugin | Description |
|--------|-------------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin Manager |
| [lsp-zero](https://github.com/VonHeikemen/lsp-zero.nvim) | Language Server for basic IDE functionality |
| [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | Debugger for python | yes |
| [telescope-nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy Finder |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax Highlighting and more syntax-tree functionality |
| [undotree](https://github.com/mbbill/undotree) | keeps track of changes in files |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | in-line diagnostics |
| [FTerm](https://github.com/numToStr/FTerm.nvim) | a floating terminal inside neovim |
| [lazygit-nvim](https://github.com/kdheepak/lazygit.nvim) | lazygit integration |
| [which-key](https://github.com/folke/which-key.nvim) | shows configured keymappings on <leader> |
| [comment](https://github.com/numToStr/Comment.nvim) | context aware comments |
| [luasnip](https://github.com/L3MON4D3/LuaSnip) | allows to define code snippets |
| [catppuccin](https://github.com/catppuccin/nvim) | colorscheme |
| [neogen](https://github.com/danymat/neogen) | generates documentation |
| [peek](https://github.com/toppair/peek) | markdown file preview |
| [vim-wakatime](https://github.com/wakatime/vim-wakatime) | easy time-tracking |
| [neodev](https://github.com/folke/neodev.nvim) | autocompletion for neovim apis |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | git information in buffers |
| [refactoring](https://github.com/ThePrimeagen/refactoring.nvim) | refactoring functionality like extracting functions or variables |
| [treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) | displays the of the current function at the top |
| [neotest](https://github.com/nvim-neotest/neotest) | prettier tests |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | formatters |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | linters |
| [mason.nviml](https://github.com/williamboman/mason.nvim) | portable package manager |
| [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim) | vertical lines to highlight indentation |
| [todo-comments](https://github.com/folke/todo-comments.nvim) | highlights TODO's in code |
| [noice.nvim](https://github.com/folke/noice.nvim) | prettier messages and statusline |
| [aerial.nvim](https://github.com/stevearc/aerial.nvim) | outline |
| [mini.nvim](https://github.com/echasnovski/mini.nvim/tree/main) | plugin-ecosystem |


---

## nvim-dap-python post-install

[nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) requires
debugpy to run. Since I like to keep everything that has to do with neovim in
one folder. I've created a `.virtualenvs` subfolder and installed it there

```shell
cd ~/.config/nvim
mkdir .virtualenvs
cd .virtualenvs
python venv .virtualenvs
python -m venv debugpy
debugpy/bin/python -m pip install debugpy
```

in neovim run (:warning:treesitter-plugin required!!)

```
:TSInstall python
```

## formatter / linter post-install

Use `:Mason` to open Mason and install the formatters and linters you want to use.

## peek pre-install

[deno](https://deno.land/) is required for rendering markdown. Install it
from the package repo of your distro.

## indent-blankline

add highlight-groups in init
