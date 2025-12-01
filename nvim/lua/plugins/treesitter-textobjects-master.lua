local textObj = require("core.utils").extraTextobjMaps
local modes   = { "n", "v", "x", "o" }

return { -- treesitter-based textobjs
        "nvim-treesitter/nvim-treesitter-textobjects",
        enabled      = true,
        branch       = "master",
        dependencies = "nvim-treesitter",
        event        = "VeryLazy",
        -- lazy         = false,
        cmd          = { -- commands need to be defined, since used in various utility functions
                "TSTextobjectSelect",
                "TSTextobjectSwapNext",
                "TSTextobjectSwapPrevious",
                "TSTextobjectGotoNextStart",
                "TSTextobjectGotoPreviousStart",
                "TSTextobjectPeekDefinitionCode",
                "TSTextobjectRepeatLastMove",
                "TSTextobjectRepeatLastMoveNext",
                "TSTextobjectRepeatLastMoveOpposite",
                "TSTextobjectRepeatLastMovePrevious",
        },
        keys         = {
                ---[[ COMMENT OPERATIONS
                { -- COMMENT SINGLE
                        "q",
                        function() vim.cmd.TSTextobjectSelect("@comment.outer") end,
                        mode = "o", -- only operator-pending to not conflict with selection-commenting
                        desc = "󰆈 Single Comment",
                },
                { -- COMMENT STICKY DELETE
                        "dq",
                        function()
                                local prevCursor = vim.api.nvim_win_get_cursor(0)
                                vim.cmd.TSTextobjectSelect("@comment.outer")
                                vim.cmd.normal{ "d", bang = true }
                                vim.cmd.normal("zz^")
                                vim.api.nvim_win_set_cursor(0, prevCursor)
                        end,
                        desc = "󰆈 Sticky Delete Comment",
                },
                { -- COMMENT CHANGE
                        "cq",
                        function()
                                vim.cmd.TSTextobjectSelect("@comment.outer")
                                vim.cmd.normal{ "d", bang = true }
                                local comStr = vim.trim( vim.bo.commentstring:format("") )
                                local line   = vim.api.nvim_get_current_line():gsub("%s+$", "")
                                vim.api.nvim_set_current_line(line .. " " .. comStr .. " ")
                                vim.cmd.startinsert{ bang = true }
                        end,
                        desc = "󰆈 Change Comment",
                },
                --]]

                ---[[ MOVE & SWAP
                { -- COMMENT PREV
                        "<A-Q>",
                        "<cmd>TSTextobjectGotoPreviousStart @comment.outer<CR>",
                        mode = modes,
                        desc = " Goto prev comment",
                },
                { -- COMMENT NEXT
                        "<A-q>",
                        "<cmd>TSTextobjectGotoNextStart @comment.outer<CR>",
                        mode = modes,
                        desc = " Goto next comment",
                },
                { -- FUNCTION PREV
                        "<A-F>",
                        "<cmd>TSTextobjectGotoPreviousStart @function.outer<CR>",
                        mode = modes,
                        desc = " Goto prev function",
                },
                { -- FUNCTION NEXT
                        "<A-f>",
                        "<cmd>TSTextobjectGotoNextStart @function.outer<CR>",
                        mode = modes,
                        desc = " Goto next function",
                },
                { -- CONDITION PREV
                        "<A-O>",
                        "<cmd>TSTextobjectGotoPreviousStart @conditional.inner<CR>",
                        mode = modes,
                        desc = "󱕆 Goto prev condition",
                },
                { -- CONDITION NEXT
                        "<A-o>",
                        "<cmd>TSTextobjectGotoNextStart @conditional.inner<CR>",
                        mode = modes,
                        desc = "󱕆 Goto next condition",
                },
                { -- CALL PREV
                        "<A-C>",
                        "<cmd>TSTextobjectGotoPreviousStart @call.outer<CR>",
                        mode = modes,
                        desc = "󰡱 Goto prev call",
                },
                { -- CALL NEXT
                        "<A-c>",
                        "<cmd>TSTextobjectGotoNextStart @call.outer<CR>",
                        mode = modes,
                        desc = "󰡱 Goto next call",
                },
                { -- LOOP PREV
                        "<A-U>",
                        "<cmd>TSTextobjectGotoPreviousStart @loop.outer<CR>",
                        mode = modes,
                        desc = "󰛤 Goto prev loop",
                },
                { -- LOOP NEXT
                        "<A-u>",
                        "<cmd>TSTextobjectGotoNextStart @loop.outer<CR>",
                        mode = modes,
                        desc = "󰛤 Goto next loop",
                },
                { -- ASSIGNMENT PREV
                        "<A-S>",
                        "<cmd>TSTextobjectGotoPreviousStart @assignment.lhs<CR>",
                        mode = modes,
                        desc = "󰛤 Goto prev assignment",
                },
                { -- ASSIGNMENT NEXT
                        "<A-s>",
                        "<cmd>TSTextobjectGotoNextStart @assignment.lhs<CR>",
                        mode = modes,
                        desc = "󰛤 Goto next assignment",
                },
                { -- VALUE PREV
                        "<A-V>",
                        "<cmd>TSTextobjectGotoPreviousStart @assignment.rhs<CR>",
                        mode = modes,
                        desc = "󰛤 Goto prev value",
                },
                { -- VALUE NEXT
                        "<A-v>",
                        "<cmd>TSTextobjectGotoNextStart @assignment.rhs<CR>",
                        mode = modes,
                        desc = "󰛤 Goto next value",
                },
                { -- TYPE PREV
                        "<A-T>",
                        "<cmd>TSTextobjectGotoPreviousStart @assignment.outer<CR>",
                        mode = modes,
                        desc = "󰛤 Goto prev type",
                },
                { -- TYPE NEXT
                        "<A-t>",
                        "<cmd>TSTextobjectGotoNextStart @assignment.outer<CR>",
                        mode = modes,
                        desc = "󰛤 Goto next type",
                },
                { -- PARAMETER PREV
                        "<A-A>",
                        "<cmd>TSTextobjectGotoPreviousStart @parameter.inner<CR>",
                        mode = modes,
                        desc = "󰏪 Goto prev parameter",
                },
                { -- PARAMETER NEXT
                        "<A-a>",
                        "<cmd>TSTextobjectGotoNextStart @parameter.inner<CR>",
                        mode = modes,
                        desc = "󰏪 Goto next parameter",
                },
                { -- PARAMETER PREV SWAP
                        "<A-{>",
                        "<cmd>TSTextobjectSwapPrevious @parameter.inner<CR>",
                        mode = { "n", "x", "o" },
                        desc = "󰏪 Swap prev parameter",
                },
                { -- PARAMETER NEXT SWAP
                        "<A-}>",
                        "<cmd>TSTextobjectSwapNext @parameter.inner<CR>",
                        mode = { "n", "x", "o" },
                        desc = "󰏪 Swap next parameter",
                },
                --]]

                ---[[ TEXT OBJECT SELECT
                { -- RETURN INNER
                        "a<CR>",
                        function()
                                vim.cmd.TSTextobjectSelect("@return.outer")
                        end,
                        mode = { "x", "o" },
                        desc = "↩ outer return",
                },
                { -- RETURN INNER
                        "<CR>",
                        function()
                                vim.cmd.TSTextobjectSelect("@return.inner")
                        end,
                        mode = "o",
                        desc = "↩ inner return",
                },
                { -- REGEX OUTER
                        "a/",
                        function()
                                vim.cmd.TSTextobjectSelect("@regex.outer")
                        end,
                        mode = { "x", "o" },
                        desc = " outer regex",
                },
                { -- REGEX INNER
                        "i/",
                        function()
                                vim.cmd.TSTextobjectSelect("@regex.inner")
                        end,
                        mode = { "x", "o" },
                        desc = "󰛤 inner regex",
                },
                { -- FUNCTION OUTER
                        "a" .. textObj.func,
                        function()
                                vim.cmd.TSTextobjectSelect("@function.outer")
                        end,
                        mode = { "x", "o" },
                        desc = " outer function",
                },
                { -- FUNCTION INNER
                        "i" .. textObj.func,
                        function()
                                vim.cmd.TSTextobjectSelect("@function.inner")
                        end,
                        mode = { "x", "o" },
                        desc = " inner function",
                },
                { -- CONDITION OUTER
                        "a" .. textObj.condition,
                        function()
                                vim.cmd.TSTextobjectSelect("@condition.outer")
                        end,
                        mode = { "x", "o" },
                        desc = "󱕆 outer condition",
                },
                { -- CONDITION INNER
                        "i" .. textObj.condition,
                        function()
                                vim.cmd.TSTextobjectSelect("@condition.inner")
                        end,
                        mode = { "x", "o" },
                        desc = "󱕆 inner condition",
                },
                { -- CALL OUTER
                        "a" .. textObj.call,
                        function()
                                vim.cmd.TSTextobjectSelect("@call.outer")
                        end,
                        mode = { "x", "o" },
                        desc = "󰡱 outer call",
                },
                { -- CALL INNER
                        "i" .. textObj.call,
                        function()
                                vim.cmd.TSTextobjectSelect("@call.inner")
                        end,
                        mode = { "x", "o" },
                        desc = "󰡱 inner call",
                },
                --]]

                ---[[ REPEATABLE ACTIONS
                {
                        "<C-Up>",
                        "<cmd>TSTextobjectRepeatLastMovePrevious<CR>",
                        mode = modes,
                        desc = "󰑖 Repeat to Prev",
                },
                {
                        "<C-Down>",
                        "<cmd>TSTextobjectRepeatLastMoveNext<CR>",
                        mode = modes,
                        desc = "󰑖 Repeat to Next",
                },
                --]]
                ---[[ PEEK DEFINITION
                {
                        ",,",
                        "<cmd>TSTextobjectPeekDefinitionCode @class.outer<CR>",
                        mode = modes,
                        desc = "󰏪 Peek Definition",
                },
                --]]
        },
}
