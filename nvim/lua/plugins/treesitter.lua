return {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        event  = "BufReadPre",
        build  = ":TSUpdate",
        config = function()
                require("nvim-treesitter.configs").setup({
                        ensure_installed      = "all",
                        ignore_install        = { "comment" },
                        auto_install          = true,
                        highlight             = {
                                enable  = true,
                                ---@diagnostic disable-next-line: unused-local
                                disable = function(lang, buf)
                                        local max_filesize = 100 * 1024
                                        local ok, stats    = pcall(vim.loop.fs_stat,
                                                                   vim.api.nvim_buf_get_name(buf))
                                        if ok and stats and stats.size > max_filesize then
                                                return true
                                        end
                                end,
                        },
                        indent                = {
                                enable  = true,
                                disable = { "markdown" },
                        },
                        textobjects           = {
                                select = {
                                        lookahead                      = true,
                                        include_surrounding_whitespace = false,
                                },
                        },
                        incremental_selection = {
                                enable  = true,
                                keymaps = {
                                        init_selection    = "<leader><leader>v",
                                        node_incremental  = "<CR>",
                                        node_decremental  = "<Backspace>",
                                        scope_incremental = false,
                                },
                        },
                        refactor              = {
                                highlight_definitions   = { enable = true },
                                highlight_current_scope = { enable = true },
                                smart_rename            = { enable = true, keymaps = { smart_rename = "grr" } },
                                navigation              = {
                                        enable  = true,
                                        keymaps = {
                                                goto_definition      = "gnd",
                                                list_definitions     = "gnD",
                                                list_definitions_toc = "gO",
                                                goto_next_usage      = "<A-^>",
                                                goto_previous_usage  = "<A-#>",
                                        },
                                },
                        },
                })
        end
        ,
        { -- NODE ACTIONS
                "ckolkey/ts-node-action",
                dependencies = { "nvim-treesitter" },
                -- config = function()
                --     require("ts-node-action").setup({})
                -- end
        },
        { -- HYPRLANG
                "theRealCarneiro/hyprland-vim-syntax",
                dependencies = { "nvim-treesitter/nvim-treesitter" },
                ft           = "hypr",
        },
        { -- CONTEXT
                "nvim-treesitter/nvim-treesitter-context",
                dependencies = { "nvim-treesitter/nvim-treesitter" },
                event        = "VeryLazy",
                config       = function()
                        require"treesitter-context".setup{
                                enable              = true,
                                multiwindow         = false,
                                max_lines           = 2,
                                min_window_height   = 1,
                                line_numbers        = true,
                                multiline_threshold = 20,
                                trim_scope          = "outer",
                                mode                = "cursor",
                                separator           = nil,
                                zindex              = 20,
                                on_attach           = nil,
                        }

                        vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { underline = false })
                        vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = false })

                        vim.keymap.set("n", ",c", function()
                                               require("treesitter-context").go_to_context(vim.v.count1)
                                       end, { silent = true })
                end,
        },
}
