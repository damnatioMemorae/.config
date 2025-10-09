return {
        "ThePrimeagen/refactoring.nvim",
        event        = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
        opts         = { show_success_message = true },
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
                        mode = "x",
                        desc = "󱗘 Extract Var",
                },
                { -- EXTRACT FUNCTION
                        "<leader>fu",
                        function() require("refactoring").refactor("Extract Function") end,
                        mode = "x",
                        desc = "󱗘 Extract Func",
                },
                { -- EXTRACT FUNCTION
                        "<leader>fU",
                        function() require("refactoring").refactor("Extract Function To File") end,
                        mode = "x",
                        desc = "󱗘 Extract Func to File",
                },
        },
}
