return {
        "Wansmer/symbol-usage.nvim",
        enabled = true,
        event   = "VeryLazy",
        keys    = {
                { "<leader>os", function()
                        require("symbol-usage").toggle_globally()
                        require("symbol-usage").refresh()
                end },
        },
        config  = function()
                local bg = "Normal"
                local function h(name) return vim.api.nvim_get_hl(0, { name = name }) end
                vim.api.nvim_set_hl(0, "SymbolUsageDef",
                                    { fg = h("@lsp.type.parameter").fg, bg = h(bg).bg, bold = false })
                vim.api.nvim_set_hl(0, "SymbolUsageRef",
                                    { fg = h("@keyword").fg, bg = h(bg).bg, bold = false })
                vim.api.nvim_set_hl(0, "SymbolUsageImpl",
                                    { fg = h("@class").fg, bg = h(bg).bg, bold = false })
                vim.api.nvim_set_hl(0, "SymbolUsageRound",
                                    { fg = h("LspInlayHint").fg, bg = h(bg).bg, bold = false })

                local function text_format(symbol)
                        local res                       = {}
                        local empt                      = ""
                        local icons                     = require("core.icons").misc
                        local stacked_functions_content = symbol.stacked_count > 0
                                   and ("+%s"):format(symbol.stacked_count) or ""

                        if symbol.definition then
                                if #res > 0 then table.insert(res, { " ", "NonText" }) end
                                table.insert(res, { empt, "SymbolUsageDef" })
                                table.insert(res,
                                             { icons.LspDef .. " " .. tostring(symbol.definition), "SymbolUsageDef" })
                                table.insert(res, { empt, "SymbolUsageDef" })
                        end

                        if symbol.references then
                                if #res > 0 then table.insert(res, { " ", "NonText" }) end
                                table.insert(res, { empt, "SymbolUsageDef" })
                                table.insert(res,
                                             { icons.LspRef .. " " .. tostring(symbol.references), "SymbolUsageRef" })
                                table.insert(res, { empt, "SymbolUsageDef" })
                        end

                        if symbol.implementation then
                                if #res > 0 then table.insert(res, { " ", "NonText" }) end
                                table.insert(res, { empt, "SymbolUsageDef" })
                                table.insert(res,
                                             { icons.LspImpl .. " " .. tostring(symbol.implementation), "SymbolUsageImpl" })
                                table.insert(res, { empt, "SymbolUsageDef" })
                        end

                        if stacked_functions_content ~= "" then
                                if #res > 0 then
                                        table.insert(res, { " ", "NonText" })
                                end
                                table.insert(res, { empt, "SymbolUsageDef" })
                                table.insert(res, { " " .. tostring(stacked_functions_content), "SymbolUsageImpl" })
                                table.insert(res, { empt, "SymbolUsageDef" })
                        end

                        return res
                end

                require("symbol-usage").setup({
                        text_format    = text_format,
                        vt_position    = "textwidth",
                        -- vt_position    = "end_of_line",
                        -- vt_position    = "above",
                        vt_priority    = 1000,
                        references     = { enabled = true, include_declaration = false },
                        definition     = { enabled = true },
                        implementation = { enabled = true },
                })
        end,
}
