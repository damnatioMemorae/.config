return {
        "mfussenegger/nvim-dap",
        enabled      = true,
        event        = "VeryLazy",
        dependencies = {
                "rcarriga/nvim-dap-ui",
                "nvim-neotest/nvim-nio",
                "theHamsta/nvim-dap-virtual-text",
        },
        keys         = {
                { "<F8>", "<cmd>DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },
                { "<F9>", "<cmd>DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },
        },
        --[[
        keys         = function()
                local dap = require("dap")
                return {
                        { "[f",   dap.up,                                             desc = "DAP Up" },
                        { "]f",   dap.down,                                           desc = "DAP Down" },
                        { "<F1>", dap.hover,                                          desc = "DAP Hover",    mode = { "n", "v" } },
                        { "<F4>", function() dap.terminate({ hierarchy = true }) end, desc = "DAP Terminate" },
                        { "<F5>", dap.continue,                                       desc = "DAP Continue" },
                        {
                                "<F8>",
                                function()
                                        vim.ui.input({ prompt = "Log point message: " },
                                                     function(input) dap.set_breakpoint(nil, nil, input) end)
                                end,
                                desc =
                                "Toggle Logpoint",
                        },
                        { "<F9>",  dap.toggle_breakpoint, desc = "Toggle Breakpoint" },
                        { "<F10>", dap.step_over,         desc = "Step Over" },
                        { "<F11>", dap.step_into,         desc = "Step Into" },
                        { "<F12>", dap.step_out,          desc = "Step Out" },
                        { "<F17>", dap.run_last,          desc = "Run Last" },
                        { "<F18>", dap.run_to_cursor,     desc = "Run to Cursor" },
                        {
                                "<F21>",
                                function()
                                        vim.ui.input(
                                                { prompt = "Breakpoint condition: " },
                                                function(input) dap.set_breakpoint(input) end
                                        )
                                end,
                                desc = "Conditional Breakpoint",
                        },
                }
        end,
        --]]
        config = function()
                local dap          = require("dap")
                local ui           = require("dapui")
                local virtual_text = require("nvim-dap-virtual-text")


                dap.listeners.before.attach.ui_config           = function() ui.open() end
                dap.listeners.before.launch.ui_config           = function() ui.open() end
                dap.listeners.before.event_terminated.ui_config = function() ui.close() end
                dap.listeners.before.event_exited.ui_config     = function() ui.close() end


                dap.defaults.fallback.switchbuf = "usevisible,usetab,newtab"
                dap.adapters.codelldb           = {
                        type       = "server",
                        port       = "${port}",
                        executable = {
                                command = "codelldb",
                                args    = { "--port", "${port}" },
                        },
                }
        end,
}
