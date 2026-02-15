return {
        "folke/lazydev.nvim",
        lazy = false,
        ft   = "lua",
        opts = {
                library = {
                        "lazy.nvim",
                        "snacks.nvim",
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
        },
}
