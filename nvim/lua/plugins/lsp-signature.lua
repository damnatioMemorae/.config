return {
        "ray-x/lsp_signature.nvim",
        -- lazy = false,
        event = "InsertEnter",
        opts  = function()
                require("lsp_signature").on_attach({
                        bind            = true,
                        hint_prefix     = " 󰏪 ",
                        floating_window = false,
                        hint_scheme     = "LspSignatureHint",
                })
        end,
}
