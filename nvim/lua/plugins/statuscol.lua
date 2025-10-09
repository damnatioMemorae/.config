return {
        "luukvbaal/statuscol.nvim",
        enabled = false,
        event   = "VeryLazy",
        config  = function()
                vim.opt.foldcolumn = "1"
                local builtin      = require("statuscol.builtin")
                require("statuscol").setup({
                        relculright = true,
                        bt_ingore   = { "nofile", "Outline" },
                        segments    = {
                                { -- SIGNS
                                        -- text = {"%s"},
                                        sign = {
                                                namespace = { "gitsigns" },
                                                -- maxwidth  = 1,
                                                -- colwidth  = 1,
                                        },
                                        click = "v:lua.ScSa",
                                },
                                { -- LNUM
                                        text  = { builtin.lnumfunc, " " },
                                        click = "v:lua.ScLa",
                                },
                                { -- FOLD
                                        text = { builtin.foldfunc, " " },
                                        click = "v:lua.ScFa",
                                },
                        },
                })
        end,
}
