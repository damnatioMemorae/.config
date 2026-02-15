return {
        "YaroSpace/dev-tools.nvim",
        dependencies = {
                "nvim-treesitter/nvim-treesitter",
                {
                        "folke/snacks.nvim",
                        opts = {
                                picker   = { enabled = true },
                                terminal = { enabled = true },
                        },
                },
                {
                        "ThePrimeagen/refactoring.nvim",
                        dependencies = { "nvim-lua/plenary.nvim" },
                },
        },
        opts = {
                actions          = {},
                filetypes        = {
                        include = {},
                        exclude = {},
                },
                builting_actions = {
                        include = {},
                        exclude = {},
                },
                action_opts      = {
                        {
                                group = "Debugging",
                                name  = "Log vars under cursor",
                                opts  = {
                                        logger = nil,
                                        keymap = nil,
                                },
                        },
                        {
                                group = "Specs",
                                name  = "Watch specs",
                                opts  = {
                                        tree_cmd     = nil,
                                        test_cmd     = nil,
                                        tree_tag     = nil,
                                        terminal_cmd = nil,
                                },
                        },
                        {
                                group = "Todo",
                                name  = "Open todo",
                                opts = {
                                        filename = nil,
                                        template = nil
                                }
                        }
                },
                ui               = {
                        override      = true,
                        group_actions = true,
                        keymaps       = { filter = "<C-b>", open_group = "<Right>", close_group = "<Left>" },
                },
                debug            = false,
                cache            = true,
        },
}
