return {
        "chrisgrieser/nvim-lsp-endhints",
        keys  = {
                { "<leader>oH", function() require("lsp-endhints").toggle() end, desc = "󰑀 Endhints" },
        },
        opts  = {
                icons = {
                        type      = "󰜁 ",
                        parameter = "󰏪 ",
                        offspec   = " ", -- hint kind not defined in official LSP spec
                        unknown   = "? ", -- hint kind is nil
                },
                label = { sameKindSeparator = " " },
        },
}
