return {
        "OXY2DEV/foldtext.nvim",
        -- enabled = false,
        -- event   = "VeryLazy",
        config  = function()
                require("foldtext").setup({
                        ignore_buftypes  = {},
                        ignore_filetypes = {},
                        condition        = function()
                                return true;
                        end,
                        pattern          = '[\'"](.+)[\'"]',
                        styles           = {
                                default = {
                                        {
                                                kind      = "bufline",
                                                delimiter = "...",
                                                hl        = "Comment",
                                        },
                                },
                                ts_expr = {
                                        parts = {
                                                {
                                                        kind      = "bufline",
                                                        delimiter = "...",
                                                        hl        = "Comment",
                                                },
                                        },
                                },
                        },
                })
        end,
}
