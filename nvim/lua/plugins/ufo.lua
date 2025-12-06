function cmd()
        vim.cmd.normal("^zz")
end

local modes = { "n", "x" }

return {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        event        = "LspAttach",
        keys         = {
                { "<leader>if", function() require("ufo").inspect() end, cmd(), desc = " Fold Info" },

                { -- 0
                        "<A-0>",
                        function()
                                require("ufo").closeAllFolds()
                                -- require("ufo").openFoldsExceptKinds{ "region" }
                                cmd()
                        end,
                        mode = modes,
                        desc = " Close L0 Folds",
                },
                { -- 1
                        "<A-1>",
                        function()
                                require("ufo").closeFoldsWith(1)
                                cmd()
                        end,
                        mode = modes,
                        desc = "d Close L1 Folds",
                },
                { -- 2
                        "<A-2>",
                        function()
                                require("ufo").closeFoldsWith(2)
                                cmd()
                        end,
                        mode = modes,
                        desc = " Close L2 Folds",
                },
                { -- 3
                        "<A-3>",
                        function()
                                require("ufo").closeFoldsWith(3)
                                cmd()
                        end,
                        mode = modes,
                        desc = " Close L3 Folds",
                },
                { -- 4
                        "<A-4>",
                        function()
                                require("ufo").closeFoldsWith(4)
                                cmd()
                        end,
                        mode = modes,
                        desc = " Close L4 Folds",
                },
                { -- 5
                        "<A-5>",
                        function()
                                require("ufo").closeFoldsWith(5)
                                cmd()
                        end,
                        mode = modes,
                        desc = " Close L5 Folds",
                },
                { -- 6
                        "<A-6>",
                        function()
                                require("ufo").closeFoldsWith(6)
                                cmd()
                        end,
                        mode = modes,
                        desc = " Close L5 Folds",
                },
                { -- OPEN ALL
                        "<A-C-right>",
                        function()
                                require("ufo").openFoldsExceptKinds{}
                                cmd()
                        end,
                        mode = modes,
                        desc = " Open All Folds",
                },
                { -- CLOSE ALL
                        "<A-C-left>",
                        function()
                                -- local msg = require("ufo.main").inspectBuf()[6]
                                -- vim.notify(msg[2], vim.log.levels.DEBUG)
                                require("ufo").openFoldsExceptKinds{
                                        "region",
                                        "table_constructor",
                                        "function_definition",
                                        "arguments",
                                        "function_declaration",
                                        "for_statement",
                                        -- "if_statement",
                                        -- "case_statement",
                                        -- "comment",
                                        -- "class_specifier",
                                        -- "array",
                                        -- "object",
                                        -- "pair",
                                        -- "rule_set",
                                }
                                cmd()
                        end,
                        mode = modes,
                        desc = " Close All Folds",
                },
                { -- FOLD PREVIEW
                        "<A-,>",
                        function()
                                local winid = require("ufo").peekFoldedLinesUnderCursor()
                                if not winid then vim.lsp.buf.hover() end
                                cmd()
                        end,
                        desc = " Fold Preview",
                },
                { -- GOTO PREVIOUS FOLD START
                        "<A-Up>",
                        function()
                                require("ufo").goPreviousStartFold()
                                cmd()
                        end,
                        mode = modes,
                        desc = " Goto Previous Fold",
                },
        },
        init         = function()
                vim.opt.foldcolumn     = "0"
                vim.opt.foldlevel      = 99
                vim.opt.foldlevelstart = 99
                vim.opt.foldenable     = true
        end,
        opts         = {
                close_fold_kinds_for_ft = {
                        cpp      = { "comment" },
                        c        = { "comment" },
                        default  = { "comment" },
                        json     = { "array" },
                        -- lua      = { "comment" },
                        lua      = {},
                        markdown = {},
                        python   = { "imports", "comment" },
                        sh       = { "imports", "comment" },
                        toml     = { "imports", "comment" },
                        zsh      = { "if_statement", "for_statement", "function_definition" },
                },
                open_fold_hl_timeout    = 0,
                preview                 = {
                        win_config = {
                                border       = require("core.icons").misc.Borders,
                                winblend     = 0,
                                winhighlight = "NormalFloat:NormalFloat",
                        },
                },
                provider_selector       = function(_bufnr, ft, _buftype)
                        local lspWithOutFolding = { "markdown", "zsh", "bash", "css", "json" }
                        if vim.tbl_contains(lspWithOutFolding, ft) then
                                return { "treesitter", "indent" }
                        end
                        return { "treesitter", "indent" }
                end,
                fold_virt_text_handler  = function()
                        -- return custom_foldtext()
                        vim.wo.foldtext =
                        [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) ]]
                end,
        },
}
