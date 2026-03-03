local icons = require("core.icons")

------------------------------------------------------------------------------------------------------------------------
-- VARIABLES

vim.g.prefix            = ","
vim.g.projects_dir      = vim.env.HOME .. "/deeznuts/"
vim.g.mapleader         = " "
vim.g.maplocalleader    = "<Nop>"

-- BORDERS
vim.g.borderStyle       = icons.borders.empty
vim.g.borderTop         = icons.borders.top
vim.g.borderBottom      = icons.borders.bottom
vim.g.borderLeft        = icons.borders.left
vim.g.borderRight       = icons.borders.right
vim.g.borderTopEmpty    = icons.borders.emptyTop
vim.g.borderBottomEmpty = icons.borders.emptyBottom
vim.g.borderLeftEmpty   = icons.borders.emptyLeft
vim.g.borderRightEmpty  = icons.borders.emptyRight

vim.g.borderStyleNone   = "none"
vim.g.backdrop          = 80
vim.g.blend             = 0
vim.g.winblend          = 0
vim.g.localRepos        = vim.fs.normalize("$HOME/deeznuts/")

------------------------------------------------------------------------------------------------------------------------
-- TREESITTER

local default_treesitter_branch = (vim.fn.executable("make") == 1 and
        vim.fn.executable("tree-sitter") == 1) and "main" or "master"
vim.g.treesitter_branch         = vim.env.NVIM_TREESITTER_BRANCH or default_treesitter_branch

------------------------------------------------------------------------------------------------------------------------
--[[ FUZZY SEARCH

vim.o.wildmode = "noselect"
vim.api.nvim_create_autocmd("CmdlineChanged", {
        pattern  = ":",
        callback = function()
                vim.fn.wildtrigger()
        end,
})

function _G.fuzzySearch(text, _)
        local files = vim.fn.glob("**/*", true, true)

        return vim.fn.matchfuzzy(files, text)
end

vim.o.findfunc = "v:lua.fuzzySearch"
--]]
