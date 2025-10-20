return {
        "luukvbaal/statuscol.nvim",
        enabled = false,
        event   = "VeryLazy",
        config  = function()
                local builtin = require("statuscol.builtin")
                require("statuscol").setup({
                        relculright   = true,
                        bt_ingore     = { "nofile", "Outline" },
                        segments      = {
                                { -- SIGNS
                                        -- text = {"%s"},
                                        sign = {
                                                namespace = { "gitsigns" },
                                                -- namespace = { "dap" },
                                                maxwidth  = 1,
                                                colwidth  = 1,
                                                -- click     = "DapToggleBreakpoint",
                                        },
                                        click = "v:lua.ScSa",
                                },
                                { -- LNUM
                                        text  = { builtin.lnumfunc, " " },
                                        click = "v:lua.ScLa",
                                },
                                { -- FOLD
                                        text  = { builtin.foldfunc, " " },
                                        click = "v:lua.ScFa",
                                },
                        },
                        clickhandlers = {
                                Lnum                   = builtin.lnum_click,
                                FoldClose              = builtin.foldclose_click,
                                FoldOpen               = builtin.foldopen_click,
                                FoldOther              = builtin.foldother_click,
                                DapBreakpointRejected  = builtin.toggle_breakpoint,
                                DapBreakpoint          = builtin.toggle_breakpoint,
                                DapBreakpointCondition = builtin.toggle_breakpoint,
                                ["diagnostic/signs"]   = builtin.diagnostic_click,
                                gitsigns               = builtin.gitsigns_click,
                        },
                })
        end,
}
