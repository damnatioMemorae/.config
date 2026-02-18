local icons = require("core.icons")

return {
        "chrisgrieser/nvim-lsp-endhints",
        event = "LspAttach",
        keys  = { { "<leader>oh", function() require("lsp-endhints").toggle() end, desc = "LSP Inlay Hints - Toggle" } },
        opts  = {
                icons = {
                        type      = icons.symbolKindsAlt.Type .. " ",
                        parameter = icons.symbolKinds.Parameter .. " ",
                        offspec   = icons.misc.offSpec .. " ",
                        unknown   = "?" .. " ",
                },
                label = {
                        truncateAtChars   = 40,
                        padding           = 1,
                        marginLeft        = 0,
                        sameKindSeparator = ", ",
                },
        },
}
