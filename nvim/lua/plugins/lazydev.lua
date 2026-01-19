return {
        {
                "folke/lazydev.nvim",
                enabled = true,
                ft   = "lua",
                opts = {
                        library = {
                                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                                { path = "snacks.nvim",        words = { "Snacks" } },
                                { path = "lazy.nvim",          words = { "LazyVim" } },
                        },
                },
        },
        {
                "Bilal2453/luvit-meta",
                enabled = true,
        },
}
