# NVIM-CONFIG

To use the configuration you need to copy the folder into your neovim-configuration folder (default: `~/.config/nvim`), start
up neovim, run `:Lazy` and check the config for `post-install` sections for the plugins.

> Check `./lua/plugins` for configurations of each plugin

The following plugins are used:

| Plugin | Description |
|--------|-------------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin Manager |
| [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | Debugger for python |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax Highlighting and more syntax-tree functionality |
| [undotree](https://github.com/mbbill/undotree) | keeps track of changes in files |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | in-line diagnostics |
| [FTerm](https://github.com/numToStr/FTerm.nvim) | a floating terminal inside neovim |
| [luasnip](https://github.com/L3MON4D3/LuaSnip) | allows to define code snippets |
| [neogen](https://github.com/danymat/neogen) | generates documentation |
| [neodev](https://github.com/folke/neodev.nvim) | autocompletion for neovim apis |
| [refactoring](https://github.com/ThePrimeagen/refactoring.nvim) | refactoring functionality like extracting functions or variables |
| [treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) | displays the of the current function at the top |
| [neotest](https://github.com/nvim-neotest/neotest) | prettier tests |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | formatters |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | linters |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | portable package manager |
| [todo-comments](https://github.com/folke/todo-comments.nvim) | highlights TODO's in code |
| [mini.nvim](https://github.com/echasnovski/mini.nvim/tree/main) | plugin-ecosystem |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | QoL plugins |



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


# TODOs

- add more relevant poetry commands to overseer (`install`, `env remove`)
- visual-mode move block (with "<") not working for big blocks 
