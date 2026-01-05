vim.g.projects_dir        = vim.env.HOME .. "/deeznuts/"
vim.g.mapleader           = " "
vim.g.maplocalleader      = "<Nop>"
-- vim.g.borderStyle    = "single"
vim.g.borderStyle         = { " ", " ", " ", " ", " ", " ", " ", " " }
vim.g.borderStyleNone     = "none"
vim.g.backdrop            = 80
vim.g.blend               = 0
vim.g.winblend            = 20
vim.g.localRepos          = vim.fs.normalize("$HOME/dev/")

local default_treesitter_branch = (vim.fn.executable("make") == 1 and
        vim.fn.executable("tree-sitter") == 1) and "main" or "master"
vim.g.treesitter_branch         = vim.env.NVIM_TREESITTER_BRANCH or default_treesitter_branch
