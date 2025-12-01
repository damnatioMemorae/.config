-- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
return {
        "numToStr/Comment.nvim",
        enabled = false,
        event = "VeryLazy",
        opts  = {
                padding   = true,
                sticky    = true,
                ignore    = nil,
                toggler   = {
                        line  = "qq",
                        block = "gb",
                },
                opleader  = {
                        line  = "q",
                        block = "qb",
                },
                extra     = {
                        above = "qO",
                        below = "qo",
                        eol   = "Q",
                },
                mappings  = {
                        basic = true,
                        extra = true,
                },
                pre_hook  = function ()
                        vim.cmd.normal("zz")
                end,
                post_hook = nil,
        },
}
