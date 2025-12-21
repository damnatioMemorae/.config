return {
        "saghen/blink.cmp",
        lazy         = false,
        build        = "cargo build --release",
        version      = "1.*",
        ---[[
        dependencies = {
                { "saghen/blink.compat" },
                { "niuiic/blink-cmp-rg.nvim" },
                { "joelazar/blink-calc" },
                {
                        "L3MON4D3/LuaSnip",
                        dependencies = {
                                "rafamadriz/friendly-snippets",
                                config = function()
                                        require("luasnip.loaders.from_vscode").lazy_load()
                                end,
                        },
                },
        },
        --]]
        opts         = {
                snippets   = { preset = "luasnip" },
                completion = {
                        documentation = {
                                auto_show          = true,
                                auto_show_delay_ms = 50,
                                window             = { border = "single" },
                                --[[#region
                                draw               = function(data)
                                        ---@type integer
                                        local buf     = data.window.buf;
                                        ---@type integer
                                        local src_buf = vim.api.nvim_get_current_buf();

                                        ---@type string[]
                                        local lines = {};

                                        if data.item and data.item.documentation then
                                                lines = vim.split(data.item.documentation.value or "", "\n",
                                                                  { trimempty = true });
                                        end

                                        ---@type string[]
                                        local details = vim.split(data.item.detail or "", "\n", { trimempty = true });

                                        if #details > 0 then
                                                table.insert(details, 1, string.format("```%s", vim.bo[src_buf].ft or ""));
                                                table.insert(details, "```");
                                                if #lines > 0 then
                                                        details = vim.list_extend(details,
                                                                                  { "", "Detail: ", "--------", "" });
                                                end
                                        end

                                        local visible_lines = vim.list_extend(details, lines);
                                        vim.api.nvim_buf_set_lines(buf, 0, -1, false, visible_lines);
                                        if vim.g.__reg_doc ~= true then
                                                vim.treesitter.language.register("markdown", "blink-cmp-documentation");
                                                vim.g.__reg_doc = true;
                                        end
                                        if package.loaded["markview"] then
                                                local win = data.window:get_win();
                                                if win then
                                                        vim.bo[buf].ft = "markdown";
                                                        require("markview").render(buf,
                                                                                   { enable = true, hybrid_mode = false });
                                                        vim.bo[buf].ft = "blink-cmp-documentation";
                                                end
                                                vim.defer_fn(function()
                                                                     win = data.window:get_win();
                                                                     if win then
                                                                             vim.wo[win].signcolumn = "no";
                                                                     end
                                                                     vim.bo[buf].ft = "markdown";
                                                                     require("markview").render(buf,
                                                                                                { enable = true, hybrid_mode = false });
                                                                     vim.bo[buf].ft = "blink-cmp-documentation";
                                                             end, 25);
                                        end
                                end,
                                --#endregion]]
                        },
                        trigger       = {
                                prefetch_on_insert                   = true,
                                show_on_backspace                    = false,
                                show_on_backspace_in_keyword         = false,
                                show_on_backspace_after_accept       = false,
                                show_on_backspace_after_insert_enter = false,
                                show_on_insert                       = false,
                                show_on_accept_on_trigger_character  = false,
                                show_on_blocked_trigger_characters   = {},
                        },
                        list          = {
                                selection = { preselect = false, auto_insert = false },
                                cycle     = { from_bottom = true, from_top = true },
                        },
                        menu          = {
                                min_width          = 40,
                                max_height         = 30,
                                border             = nil,
                                winblend           = 0,
                                scrolloff          = 4,
                                scrollbar          = true,
                                direction_priority = { "s", "n" },
                                auto_show          = true,
                                draw               = {
                                        align_to   = "label",
                                        padding    = 1,
                                        gap        = 1,
                                        treesitter = { "lsp" },
                                        columns    = {
                                                { "kind_icon",   gap = 0 },
                                                { "label",       gap = 0 },
                                                { "source_name", gap = 0 },
                                                { "kind",        gap = 0 },
                                        },
                                        components = {
                                                kind_icon   = {
                                                        ellipsis = false,
                                                        text     = function(ctx)
                                                                if ctx.source_id == "cmdline" then return end
                                                                return ctx.kind_icon
                                                        end,
                                                },
                                                source_name = {
                                                        -- text  = function(ctx) return "[" .. ctx.source_name .. "]" end,
                                                        text = function(ctx)
                                                                if ctx.source_id == "cmdline" then return end
                                                                return ctx.source_name:sub(1, 4)
                                                                -- return "[" .. ctx.source_name:sub(1, 4) .. "]"
                                                        end,
                                                },
                                        },
                                },
                        },
                },
                fuzzy      = {
                        -- implementation    = "lua",
                        implementation    = "prefer_rust_with_warning",
                        max_typos         = 0,
                        frecency          = {
                                enabled = true,
                                path    = vim.fn.stdpath("state") .. "/blink/cmp/frecency.dat",
                        },
                        use_proximity     = true,
                        sorts             = {
                                ---@diagnostic disable-next-line: unused-local
                                function(a, b)
                                        if a.label:sub(1, 1) == "_" ~= a.label:sub(1, 1) == "_" then
                                                return not a.label:sub(1, 1) == "_"
                                        end
                                end, "exact", "score", "sort_text",
                        },
                        prebuilt_binaries = {
                                download                = false,
                                ignore_version_mismatch = false,
                                force_version           = "1.*",
                        },
                },
                cmdline    = {
                        enabled    = true,
                        keymap     = {
                                preset        = "none",
                                ["<C-h>"]     = { "snippet_backward", "fallback" },
                                ["<C-l>"]     = { "snippet_forward", "fallback" },
                                ["<C-j>"]     = { "select_next", "fallback" },
                                ["<C-k>"]     = { "select_prev", "fallback" },
                                ["<C-c>"]     = { function(cmp) if cmp.is_menu_visible() then cmp.hide() else cmp.show() end end },
                                ["<C-Space>"] = {
                                        function(cmp)
                                                if cmp.is_menu_visible() then
                                                        cmp.accept()
                                                        cmp.hide()
                                                else
                                                        cmp.show()
                                                end
                                        end,
                                },
                        },
                        sources    = function()
                                local type = vim.fn.getcmdtype()
                                -- Search forward and backward
                                if type == "/" or type == "?" then return { "buffer" } end
                                -- Commands
                                if type == ":" or type == "@" then return { "cmdline" } end
                                return {}
                        end,
                        completion = {
                                trigger = {
                                        show_on_blocked_trigger_characters   = {},
                                        show_on_x_blocked_trigger_characters = {},
                                },
                                list    = { selection = { preselect = false, auto_insert = false } },
                                menu    = { auto_show = false },
                        },
                },
                sources    = {
                        default      = { "lsp", "snippets", "path", "buffer", "calc" },
                        per_filetype = {
                                ["rip-substitute"] = { "ripgrep", "buffer" },
                                gitcommit          = {},
                                lua                = { inherit_defaults = true, "ripgrep" },
                                c                  = { inherit_defaults = true, "ripgrep" },
                                cpp                = { inherit_defaults = true, "ripgrep" },
                                css                = { inherit_defaults = true, "ripgrep" },
                                json               = { inherit_defaults = true, "ripgrep" },
                                jsons              = { inherit_defaults = true, "ripgrep" },
                        },
                        providers    = {
                                calc     = { name = "calc", module = "blink-calc" },
                                snippets = {
                                        name               = "Snip",
                                        opts               = {
                                                use_show_condition    = true,
                                                use_label_description = true,
                                        },
                                        score_offset       = 140,
                                        min_keyword_length = 2,
                                },
                                lsp      = {
                                        name         = "LSP",
                                        module       = "blink.cmp.sources.lsp",
                                        opts         = { tailwind_color_icon = "██" },
                                        -- async        = true,
                                        -- timeout_ms   = 4000,
                                        score_offset = 160,
                                        fallbacks    = {},
                                        override     = {
                                                get_trigger_characters = function(self)
                                                        local trigger_characters = self:get_trigger_characters()
                                                        vim.list_extend(trigger_characters, { "\n", "\t", " " })
                                                        return trigger_characters
                                                end,
                                        },
                                },
                                path     = {
                                        name         = "Path",
                                        module       = "blink.cmp.sources.path",
                                        score_offset = 260,
                                        opts         = {
                                                trailing_slash               = true,
                                                label_trailing_slash         = true,
                                                get_cwd                      = function(_)
                                                        return vim.fn.getcwd()
                                                end,
                                                show_hidden_files_by_default = true,
                                        },
                                },
                                buffer   = {
                                        name         = "Buf",
                                        score_offset = 60,
                                        max_items    = 8,
                                        opts         = { get_bufnrs = vim.api.nvim_list_bufs },
                                },
                                omni     = {
                                        name         = "Omni",
                                        module       = "blink.cmp.sources.complete_func",
                                        score_offset = 60,
                                        opts         = { disable_omnifunc = { "v:lua.vim.lsp.omnifunc" } },
                                },
                                ripgrep  = {
                                        module       = "blink-cmp-rg",
                                        name         = "RG",
                                        score_offset = 10,
                                        max_items    = 4,
                                        opts         = {
                                                prefix_min_len = 3,
                                                ---@diagnostic disable-next-line: unused-local
                                                get_command    = function(context, prefix)
                                                        return {
                                                                "rg",
                                                                "--no-config",
                                                                "--json",
                                                                "--word-regexp",
                                                                "--smart-case",
                                                                "--",
                                                                prefix .. "[\\w_-]+",
                                                                vim.fs.root(0, ".git") or vim.fn.getcwd(),
                                                        }
                                                end,
                                                get_prefix     = function(context)
                                                        return context.line:sub(1, context.cursor[2]):match("[%w_-]+$") or
                                                                   ""
                                                end,
                                        },
                                },
                        },
                },
                keymap     = {
                        preset        = "enter",
                        ["<A-j>"]     = { "scroll_documentation_down", "fallback" },
                        ["<A-k>"]     = { "scroll_documentation_up", "fallback" },
                        ["<C-j>"]     = { "select_next", "fallback" },
                        ["<C-k>"]     = { "select_prev", "fallback" },
                        ["<C-c>"]     = { function(cmp) if cmp.is_menu_visible() then cmp.hide() else cmp.show() end end },
                        ["<C-l>"]     = { "snippet_forward", "fallback" },
                        ["<C-h>"]     = { "snippet_backward", "fallback" },
                        ["<Tab>"]     = { "select_next", "snippet_forward", "fallback" },
                        ["<S-Tab>"]   = { "select_prev", "snippet_backward", "fallback" },
                        ["<C-Space>"] = {
                                function(cmp)
                                        if cmp.is_menu_visible() then
                                                cmp.accept()
                                                cmp.hide()
                                        else
                                                cmp.show()
                                        end
                                end,
                        },
                },
                appearance = {
                        nerd_font_variant = "normal",
                        kind_icons        = require("core.icons").symbol_kinds,
                },
                signature  = { enabled = true, window = { scrollbar = false } },
        },
        opts_extend  = { "sources.default" },

        config = function(_, opts)
                require("blink-cmp").setup(opts)
        end,
}
