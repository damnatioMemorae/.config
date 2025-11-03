return {
        "ThePrimeagen/refactoring.nvim",
        event        = "LspAttach",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
        keys         = {
                { -- INLINE VARIABLE
                        "<leader>fi",
                        function() require("refactoring").refactor("Inline Variable") end,
                        mode = { "n", "x" },
                        desc = "󱗘 Inline Var",
                },
                { -- EXTRACT VARIABLE
                        "<leader>fe",
                        function() require("refactoring").refactor("Extract Variable") end,
                        mode = { "n", "x" },
                        desc = "󱗘 Extract Var",
                },
                { -- EXTRACT FUNCTION
                        "<leader>fu",
                        function() require("refactoring").refactor("Extract Function") end,
                        mode = { "n", "x" },
                        desc = "󱗘 Extract Func",
                },
                { -- EXTRACT FUNCTION
                        "<leader>fU",
                        function() require("refactoring").refactor("Extract Function To File") end,
                        mode = { "n", "x" },
                        desc = "󱗘 Extract Func to File",
                },
        },
        opts         = {
                prompt_func_return_type = {
                        go   = true,
                        java = true,
                        cpp  = true,
                        c    = true,
                        h    = true,
                        hpp  = true,
                        cxx  = true,
                },
                prompt_func_param_type  = {
                        go   = true,
                        java = true,
                        cpp  = true,
                        c    = true,
                        h    = true,
                        hpp  = true,
                        cxx  = true,
                },
                printf_statements       = {},
                print_var_statements    = {},
                show_success_message    = true,
        },
        config       = function(_, opts)
                require("refactoring").setup({ opts })
        end,
}
