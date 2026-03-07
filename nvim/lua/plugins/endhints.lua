return {
        "chrisgrieser/nvim-lsp-endhints",
        event = "LspAttach",
        keys  = { {
                "<leader>oh",
                function()
                        local endhints = require("lsp-endhints")

                        Config.inlayHints = not Config.inlayHints
                        local str         = Icons.symbolKinds.Parameter .. " " .. "Inlay Hints - "

                        if Config.inlayHints then
                                endhints.enable()
                                vim.lsp.inlay_hint.enable(Config.inlayHints)
                                vim.notify(str .. "Enabled", vim.log.levels.INFO)
                        else
                                endhints.disable()
                                vim.lsp.inlay_hint.enable(Config.inlayHints)
                                vim.notify(str .. "Disabled", vim.log.levels.INFO)
                        end
                end,
                desc = "LSP Inlay Hints - Toggle",
        } },
        opts  = {
                icons = {
                        type      = Icons.symbolKindsAlt.Type .. " ",
                        parameter = Icons.symbolKinds.Parameter .. " ",
                        offspec   = Icons.misc.offSpec .. " ",
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
