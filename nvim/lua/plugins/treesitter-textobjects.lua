local textObj = require("core.utils").extraTextobjMaps
local modes   = { "n", "v", "x", "o" }

local function cmd()
        vim.cmd.normal("^zz")
end

local function jump(direction, obj)
        if direction == 0 then
                direction = "Previous"
        elseif direction == 1 then
                direction = "Next"
        end
        vim.cmd("TSTextobjectGoto" .. direction .. "Start" .. " @" .. obj)
        cmd()
end

local function swap(direction, obj)
        if direction == 0 then
                direction = "Previous"
        elseif direction == 1 then
                direction = "Next"
        end
        vim.cmd("TSTextobjectSwap" .. direction .. " @" .. obj)
        cmd()
end

return { -- treesitter-based textobjs
        "nvim-treesitter/nvim-treesitter-textobjects",
        -- enabled      = true,
        branch       = "master",
        dependencies = "nvim-treesitter/nvim-treesitter",
        event        = "VeryLazy",
        cmd          = { -- commands need to be defined, since used in various utility functions
                "TSTextobjectSelect",
                "TSTextobjectSwapNext",
                "TSTextobjectSwapPrevious",
                "TSTextobjectGotoNextStart",
                "TSTextobjectGotoPreviousStart",
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
                                cmd()
                                vim.api.nvim_win_set_cursor(0, prevCursor)
                        end,
                        desc = "󰆈 Sticky Delete Comment",
                },
                { -- COMMENT CHANGE
                        "cq",
                        function()
                                vim.cmd.TSTextobjectSelect("@comment.outer")
                                vim.cmd.normal{ "d", bang = true }
                                cmd()
                                local comStr = vim.trim{ vim.bo.commentstring:format("") }
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
                        function() jump(0, "comment.outer") end,
                        mode = modes,
                        desc = " Goto prev comment",
                },
                { -- COMMENT NEXT
                        "<A-q>",
                        function() jump(1, "comment.outer") end,
                        mode = modes,
                        desc = " Goto next comment",
                },
                { -- FUNCTION PREV
                        "<A-F>",
                        function() jump(0, "function.outer") end,
                        mode = modes,
                        desc = " Goto prev function",
                },
                { -- FUNCTION NEXT
                        "<A-f>",
                        function() jump(1, "function.outer") end,
                        mode = modes,
                        desc = " Goto next function",
                },
                { -- CONDITION PREV
                        "<A-O>",
                        function() jump(0, "conitional.outer") end,
                        mode = modes,
                        desc = "󱕆 Goto prev condition",
                },
                { -- CONDITION NEXT
                        "<A-o>",
                        function() jump(1, "conitional.outer") end,
                        mode = modes,
                        desc = "󱕆 Goto next condition",
                },
                { -- CALL PREV
                        "<A-C>",
                        function() jump(0, "call.outer") end,
                        mode = modes,
                        desc = "󰡱 Goto prev call",
                },
                { -- CALL NEXT
                        "<A-c>",
                        function() jump(1, "call.outer") end,
                        mode = modes,
                        desc = "󰡱 Goto next call",
                },
                { -- LOOP PREV
                        "<A-U>",
                        function() jump(0, "loop.outer") end,
                        mode = modes,
                        desc = "󰛤 Goto prev loop",
                },
                { -- LOOP NEXT
                        "<A-u>",
                        function() jump(1, "loop.outer") end,
                        mode = modes,
                        desc = "󰛤 Goto next loop",
                },
                { -- ASSIGNMENT PREV
                        "<A-S>",
                        function() jump(0, "assignment.lhs") end,
                        mode = modes,
                        desc = "󰛤 Goto prev assignment",
                },
                { -- ASSIGNMENT NEXT
                        "<A-s>",
                        function() jump(1, "assignment.lhs") end,
                        mode = modes,
                        desc = "󰛤 Goto next assignment",
                },
                { -- VALUE PREV
                        "<A-V>",
                        function() jump(0, "assignment.rhs") end,
                        mode = modes,
                        desc = "󰛤 Goto prev value",
                },
                { -- VALUE NEXT
                        "<A-v>",
                        function() jump(1, "assignment.rhs") end,
                        mode = modes,
                        desc = "󰛤 Goto next value",
                },
                { -- TYPE PREV
                        "<A-T>",
                        function() jump(0, "assignment.outer") end,
                        mode = modes,
                        desc = "󰛤 Goto prev type",
                },
                { -- TYPE NEXT
                        "<A-t>",
                        function() jump(1, "assignment.outer") end,
                        mode = modes,
                        desc = "󰛤 Goto next type",
                },
                { -- PARAMETER PREV
                        "<A-A>",
                        function() jump(0, "parameter.inner") end,
                        mode = modes,
                        desc = "󰏪 Goto prev parameter",
                },
                { -- PARAMETER NEXT
                        "<A-a>",
                        function() jump(1, "parameter.inner") end,
                        mode = modes,
                        desc = "󰏪 Goto next parameter",
                },
                { -- PARAMETER PREV SWAP
                        "<A-{>",
                        function() swap(0, "parameter.inner") end,
                        mode = { "n", "x", "o" },
                        desc = "󰏪 Swap prev parameter",
                },
                { -- PARAMETER NEXT SWAP
                        "<A-}>",
                        function() swap(1, "parameter.inner") end,
                        mode = { "n", "x", "o" },
                        desc = "󰏪 Swap next parameter",
                },
                --]]

                ---[[ TEXT OBJECT SELECT
                { -- RETURN INNER
                        "a<CR>",
                        function()
                                vim.cmd.TSTextobjectSelect("@return.outer")
                                cmd()
                        end,
                        mode = { "x", "o" },
                        desc = "↩ outer return",
                },
                { -- RETURN INNER
                        "<CR>",
                        function()
                                vim.cmd.TSTextobjectSelect("@return.inner")
                                cmd()
                        end,
                        mode = "o",
                        desc = "↩ inner return",
                },
                { -- REGEX OUTER
                        "a/",
                        function()
                                vim.cmd.TSTextobjectSelect("@regex.outer")
                                cmd()
                        end,
                        mode = { "x", "o" },
                        desc = " outer regex",
                },
                { -- REGEX INNER
                        "i/",
                        function()
                                vim.cmd.TSTextobjectSelect("@regex.inner")
                                cmd()
                        end,
                        mode = { "x", "o" },
                        desc = "󰛤 inner regex",
                },
                { -- FUNCTION OUTER
                        "a" .. textObj.func,
                        function()
                                vim.cmd.TSTextobjectSelect("@function.outer")
                                cmd()
                        end,
                        mode = { "x", "o" },
                        desc = " outer function",
                },
                { -- FUNCTION INNER
                        "i" .. textObj.func,
                        function()
                                vim.cmd.TSTextobjectSelect("@function.inner")
                                cmd()
                        end,
                        mode = { "x", "o" },
                        desc = " inner function",
                },
                { -- CONDITION OUTER
                        "a" .. textObj.condition,
                        function()
                                vim.cmd.TSTextobjectSelect("@condition.outer")
                                cmd()
                        end,
                        mode = { "x", "o" },
                        desc = "󱕆 outer condition",
                },
                { -- CONDITION INNER
                        "i" .. textObj.condition,
                        function()
                                vim.cmd.TSTextobjectSelect("@condition.inner")
                                cmd()
                        end,
                        mode = { "x", "o" },
                        desc = "󱕆 inner condition",
                },
                { -- CALL OUTER
                        "a" .. textObj.call,
                        function()
                                vim.cmd.TSTextobjectSelect("@call.outer")
                                cmd()
                        end,
                        mode = { "x", "o" },
                        desc = "󰡱 outer call",
                },
                { -- CALL INNER
                        "i" .. textObj.call,
                        function()
                                vim.cmd.TSTextobjectSelect("@call.inner")
                                cmd()
                        end,
                        mode = { "x", "o" },
                        desc = "󰡱 inner call",
                },
                --]]
        },
}
