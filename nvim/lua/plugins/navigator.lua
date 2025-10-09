return {
        "ray-x/navigator.lua",
        enabled      = false,
        event        = "VeryLazy",
        lazy         = false,
        dependencies = {
                { "ray-x/guihua.lua",     build = "cd lua/fzy && make" },
                { "neovim/nvim-lspconfig" },
        },
        config       = function()
                require("navigator").setup({
                        transparency = 50,
                        lsp          = {
                                enable         = false,
                                format_on_save = false,
                        },
                })
        end,
}
