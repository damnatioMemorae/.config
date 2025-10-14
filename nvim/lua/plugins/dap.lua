return {
        "mfussenegger/nvim-dap",
        enabled = false,
        dependencies = {
                { -- DAP-UI
                        "rcarriga/nvim-dap-ui",
                        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
                },
                { -- DAP-VIRTUAL-TEXT
                        "theHamsta/nvim-dap-virtual-text",
                        config = function()
                                require("nvim-dap-virtual-text").setup()
                        end,
                },
        },
        keys         = function()
                local dap = require("dap")
                return {
                        { "[f",   dap.up,                                             desc = "DAP Up" },
                        { "]f",   dap.down,                                           desc = "DAP Down" },
                        { "<F1>", require("dap.ui.widgets").hover,                    desc = "DAP Hover",    mode = { "n", "v" } },
                        { "<F4>", function() dap.terminate({ hierarchy = true }) end, desc = "DAP Terminate" },
                        { "<F5>", dap.continue,                                       desc = "DAP Continue" },
                        {
                                "<F8>",
                                function()
                                        vim.ui.input(
                                                { prompt = "Log point message: " },
                                                function(input) dap.set_breakpoint(nil, nil, input) end
                                        )
                                end,
                                desc = "Toggle Logpoint",
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
        config       = function()
                local dap                       = require("dap")

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
