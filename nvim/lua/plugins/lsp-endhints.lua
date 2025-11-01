return {
        "chrisgrieser/nvim-lsp-endhints",
        event = "LspAttach",
        keys  = {
                { "<leader>oh", function() require("lsp-endhints").toggle() end, desc = "󰑀 Endhints" },
        },
        opts  = {
                icons   = {
                        type      = "󰜁 ",
                        parameter = "󰏪 ",
                        offspec   = " ",
                        unknown   = "? ",
                },
                label   = {
                        truncateAtChars   = 40,
                        sameKindSeparator = " ",
                        marginLeft        = 0,
                        padding           = 1,
                },
                extmark = { priority = 1000 },
        },
}
