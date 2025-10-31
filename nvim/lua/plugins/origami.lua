return {
        "chrisgrieser/nvim-origami",
        enabled = false,
        event  = "VeryLazy",
        opts   = {},
        init   = function()
                vim.opt.foldlevel      = 99
                vim.opt.foldlevelstart = 99
        end,
        config = function()
                require("origami").setup{
                        useLspFoldsWithTreesitterFallback = true,
                        pauseFoldsOnSearch                = true,
                        foldtext                          = {
                                enabled          = true,
                                padding          = 0,
                                lineCount        = {
                                        template = "...",
                                        hlgroup  = "FoldMark",
                                },
                                diagnosticsCount = true,
                                gitsignsCount    = false,
                        },
                        autoFold                          = {
                                enabled = true,
                                kinds   = {
                                        -- "region",
                                        "comment",
                                        "imports"
                                },
                        },
                        foldKeymaps                       = {
                                setup                   = true,
                                hOnlyOpensOnFirstColumn = false,
                        },
                }
        end,
}
