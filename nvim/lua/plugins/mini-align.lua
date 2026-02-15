return {
        "echasnovski/mini.align",
        version = false,
        event   = "VeryLazy",
        opts    = {
                mappings = {
                        start              = vim.g.prefix .. "a",
                        start_with_preview = vim.g.prefix .. "a",
                },

                options = {
                        split_pattern   = "",
                        justify_side    = "left",
                        merge_delimiter = "",
                },

                steps = {
                        pre_split   = {},
                        split       = nil,
                        pre_justify = {},
                        justify     = nil,
                        pre_merge   = {},
                        merge       = nil,
                },

                silent = false,
        },
}
