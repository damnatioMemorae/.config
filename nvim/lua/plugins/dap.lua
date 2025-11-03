---@diagnostic disable: unknown-diag-code
return {
        "mfussenegger/nvim-dap",
        enabled      = false,
        -- event        = "VeryLazy",
        lazy         = false,
        dependencies = {
                "rcarriga/nvim-dap-ui",
                "nvim-neotest/nvim-nio",
                "theHamsta/nvim-dap-virtual-text",
        },
        config       = function()
                local dap                                          = require("dap")
                local ui                                           = require("dapui")
                local virtual_text                                 = require("nvim-dap-virtual-text")
                local widgets                                      = require("dap.ui.widgets")

                dap.listeners.before.attach.dapui_config           = function() ui.open() end
                dap.listeners.before.launch.dapui_config           = function() ui.open() end
                dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
                dap.listeners.before.event_exited.dapui_config     = function() ui.close() end

                virtual_text.setup({
                        all_references = true,
                })
                ui.setup({
                        expand_lines = true,
                        -- controls       = { enabled   = false },
                        floating     = { border = "single" },
                        render       = {
                                max_type_length = 60,
                                max_value_lines = 200,
                        },
                        controls     = {
                                -- element   = "repl",
                                enabled = true,
                                icons   = {
                                        disconnect = "",
                                        pause      = "",
                                        play       = "",
                                        run_last   = "",
                                        step_back  = "",
                                        step_into  = "",
                                        step_out   = "",
                                        step_over  = "",
                                        terminate  = "",
                                },
                        },
                        layouts      = {
                                {
                                        elements = {
                                                { id = "stacks", size = 0.7 },
                                                { id = "scopes", size = 0.3 },
                                                -- { id   = "watches", size   = 0.2 },
                                        },
                                        size     = 15,
                                        position = "bottom",
                                },
                                {
                                        elements = {
                                                { id = "repl", size = 1.0 },
                                        },
                                        size     = 54,
                                        position = "right",
                                },
                        },
                })

                vim.fn.sign_define("DapBreakpoint", {
                        text   = "󰧞",
                        texthl = "DapBreakpointSymbol",
                        linehl = "DapBreakpoint",
                        numhl  = "DapBreakpoint",
                })
                vim.fn.sign_define("DapStopped", {
                        text   = "󰧞",
                        texthl = "yellow",
                        linehl = "DapBreakpoint",
                        numhl  = "DapBreakpoint",
                })
                vim.fn.sign_define("DapBreakpointRejected", {
                        text   = "",
                        texthl = "DapStoppedSymbol",
                        linehl = "DapBreakpoint",
                        numhl  = "DapBreakpoint",
                })

                vim.keymap.set("n", "<F1>", function() widgets.sidebar(widgets.scopes) end, { desc = "Toggle Scopes" })
                vim.keymap.set("n", "<F2>", function() widgets.sidebar(widgets.frame) end, { desc = "Toggle Frames" })
                vim.keymap.set("n", "<F3>", widgets.hover, { desc = "DAP Hover" })
                vim.keymap.set("n", "<F4>", dap.run_to_cursor, { desc = "DAP Run to Cursor" })
                vim.keymap.set("n", "<F5>", function() dap.repl.toggle({ width = 50 }, "vsplit") end,
                               { desc = "Toggle REPL" })
                vim.keymap.set("n", "<F6>", ui.eval, { desc = "DAP Eval" })
                vim.keymap.set("n", "<F7>", widgets.hover, { desc = "DAP Hover" })
                vim.keymap.set("n", "<F8>", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
                vim.keymap.set("n", "<F9>", dap.step_over, { desc = "DAP Step Over" })
                vim.keymap.set("n", "<F10>", dap.step_into, { desc = "DAP Step Into" })
                vim.keymap.set("n", "<F11>", dap.step_out, { desc = "DAP Step Out" })
                vim.keymap.set("n", "<F12>", dap.step_back, { desc = "DAP Step Back" })

                -- dap.defaults.fallback.switchbuf   = "usevisible,usetab,newtab"

                --------------------------------------------------------------------------------------------------------
                -- C/C++

                dap.adapters.codelldb     = {
                        type    = "executable",
                        command = "codelldb",
                        name    = "codelldb",
                }
                dap.configurations.cpp    = {
                        {
                                name        = "[C++] Launch file",
                                type        = "codelldb",
                                request     = "launch",
                                program     = function()
                                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                                        -- return vim.fn.expand("%")
                                end,
                                cwd         = "${workspaceFolder}",
                                stopOnEntry = false,
                        },
                }

                --------------------------------------------------------------------------------------------------------
                -- BASH

                dap.adapters.bashdb       = {
                        type    = "executable",
                        command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
                        name    = "bashdb",
                }
                dap.configurations.sh     = {
                        {
                                name            = "[BASH] Launch file",
                                type            = "bashdb",
                                request         = "launch",
                                showDebugOutput = true,
                                pathBashdb      = vim.fn.stdpath("data") ..
                                           "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
                                pathBashdbLib   = vim.fn.stdpath("data") ..
                                           "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
                                trace           = true,
                                file            = "${file}",
                                program         = "${file}",
                                cwd             = "${workspaceFolder}",
                                pathCat         = "cat",
                                pathBash        = "/bin/bash",
                                pathMkfifo      = "mkfifo",
                                pathPkill       = "pkill",
                                args            = {},
                                argsString      = "",
                                env             = {},
                                terminalKind    = "integrated",
                        },
                }

                --------------------------------------------------------------------------------------------------------
                -- PYTHON

                dap.adapters.python       = function(cb, config)
                        if config.request == "attach" then
                                local port = (config.connect or config).port
                                local host = (config.connect or config).host or "127.0.0.1"
                                cb({
                                        type    = "server",
                                        port    = assert(port,
                                                         "`connect.port` is required for a python `attach` configuration"),
                                        host    = host,
                                        options = { source_filetype = "python" },
                                })
                        else
                                cb({
                                        type    = "executable",
                                        command = "path/to/virtualenvs/debugpy/bin/python",
                                        args    = { "-m", "debugpy.adapter" },
                                        options = { source_filetype = "python" },
                                })
                        end
                end
                dap.configurations.python = {
                        {
                                type       = "python",
                                request    = "launch",
                                name       = "Launch file",
                                program    = "${file}",
                                pythonPath = function()
                                        local cwd = vim.fn.getcwd()
                                        if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                                                return cwd .. "/venv/bin/python"
                                        elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                                                return cwd .. "/.venv/bin/python"
                                        else
                                                return "/usr/bin/python"
                                        end
                                end,
                        },
                }

                --------------------------------------------------------------------------------------------------------
                -- GOLANG
        end,
}
