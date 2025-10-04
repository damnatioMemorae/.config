return {
        "ray-x/lsp_signature.nvim",
        -- lazy = false,
        event = "InsertEnter",
        opts  = function()
                require("lsp_signature").on_attach({
                        bind            = false,
                        hint_prefix     = "󰏪 ",
                        floating_window = false,
                })
        end,
}
