function cmd()
        vim.cmd.normal("^zz")
end

local folded = require("core.icons").misc.folded
local modes  = { "n", "x" }

return {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        event        = "LspAttach",
        keys         = {
                { "<leader>if", vim.cmd.UfoInspect, cmd(), desc = " Fold info" },

                { -- 0
                        "<A-0>",
                        function()
                                require("ufo").closeAllFolds()
                                -- require("ufo").openFoldsExceptKinds{ "region" }
                                cmd()
                        end,
                        mode = modes,
                        desc = "󱃄 Close L0 folds",
                },
                { -- 1
                        "<A-1>",
                        function()
                                require("ufo").closeFoldsWith(1)
                                cmd()
                        end,
                        mode = modes,
                        desc = "󱃄 Close L1 folds",
                },
                { -- 2
                        "<A-2>",
                        function()
                                require("ufo").closeFoldsWith(2)
                                cmd()
                        end,
                        mode = modes,
                        desc = "󱃄 Close L2 folds",
                },
                { -- 3
                        "<A-3>",
                        function()
                                require("ufo").closeFoldsWith(3)
                                cmd()
                        end,
                        mode = modes,
                        desc = "󱃄 Close L3 folds",
                },
                { -- 4
                        "<A-4>",
                        function()
                                require("ufo").closeFoldsWith(4)
                                cmd()
                        end,
                        mode = modes,
                        desc = "󱃄 Close L4 folds",
                },
                { -- 5
                        "<A-5>",
                        function()
                                require("ufo").closeFoldsWith(5)
                                cmd()
                        end,
                        mode = modes,
                        desc = "󱃄 Close L5 folds",
                },
                { -- 6
                        "<A-6>",
                        function()
                                require("ufo").closeFoldsWith(6)
                                cmd()
                        end,
                        mode = modes,
                        desc = "󱃄 Close L5 folds",
                },
                { -- OPEN ALL
                        "<A-C-right>",
                        function()
                                require("ufo").openFoldsExceptKinds{}
                                cmd()
                        end,
                        mode = modes,
                        desc = "󱃄 Open regular folds",
                },
                { -- CLOSE ALL
                        "<A-C-left>",
                        function()
                                require("ufo").openFoldsExceptKinds{ "region" }
                                cmd()
                        end,
                        mode = modes,
                        desc = "󱃄 Close all folds",
                },
                { -- FOLD PREVIEW
                        "<A-C-Up>",
                        function()
                                local winid = require("ufo").peekFoldedLinesUnderCursor()
                                if not winid then vim.lsp.buf.hover() end
                                cmd()
                        end,
                        desc = "󱃄 Fold Preview",
                },
                { -- GOTO PREVIOUS FOLD START
                        "<A-Up>",
                        function()
                                require("ufo").goPreviousStartFold()
                                cmd()
                        end,
                        mode = modes,
                        desc = "󱃄 Close all folds",
                },
        },
        init         = function()
                vim.opt.foldcolumn     = "0"
                vim.opt.foldlevel      = 99
                vim.opt.foldlevelstart = 99
                vim.opt.foldenable     = true
        end,
        opts         = {
                -- when opening the buffer, close these fold kinds
                close_fold_kinds_for_ft = {
                        cpp      = { "comment" },
                        c        = { "comment" },
                        default  = { "comment" },
                        json     = { "array" },
                        -- lua      = { "comment" },
                        lua      = {},
                        markdown = {}, -- avoid everything becoming folded
                        python   = { "imports", "comment" },
                        sh       = { "imports", "comment" },
                        toml     = { "imports", "comment" },
                        zsh      = { "if_statement", "for_statement", "function_definition" },
                        -- use `:UfoInspect` to get see available fold kinds
                },
                open_fold_hl_timeout    = 0,
                preview                 = {
                        win_config = {
                                border       = "single",
                                winblend     = 0,
                                winhighlight = "NormalFloat:NormalFloat",
                        },
                },
                provider_selector       = function(_bufnr, ft, _buftype)
                        -- ufo accepts only two kinds as priority, see https://github.com/kevinhwang91/nvim-ufo/issues/256
                        local lspWithOutFolding = { "markdown", "zsh", "bash", "css", "json" }
                        if vim.tbl_contains(lspWithOutFolding, ft) then
                                return { "treesitter", "indent" }
                        end
                        return { "treesitter", "indent" }
                end,
                fold_virt_text_handler  = function()
                        -- return custom_foldtext()
                        -- vim.o.foldmethod = "expr"
                        -- vim.o.foldexpr   = "nvim_treesitter#foldexpr()"
                        vim.wo.foldtext =
                        [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) ]]
                end,
        },
}
