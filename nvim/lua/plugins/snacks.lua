local button = "Function"
local label  = "Comment"
-- local prefix  = "<leader><leader>"
local prefix = ","
local icons  = require("core.icons")

return {
        "folke/snacks.nvim",
        lazy     = false,
        priority = 1000,
        keys     = {
                { "<C-n>",      function() Snacks.notifier.show_history() end, desc = "Notification History" },
                { "<leader>fr", function() Snacks.rename.rename_file() end,    desc = "Rename File" },
                { "<leader>lg", function() Snacks.lazygit() end,               desc = "Lazygit" },
                { "<A-]>",      function() Snacks.words.jump(1) end,           desc = "Next Reference",      mode = { "n", "t" } },
                { "<A-[>",      function() Snacks.words.jump(-1) end,          desc = "Prev Reference",      mode = { "n", "t" } },
                { -- DELETE BUFFER
                        "<A-b>",
                        function()
                                Snacks.bufdelete()
                                vim.cmd.normal("zz")
                        end,
                        desc = "Delete Buffer",
                },
                { -- MAIN
                        "<leader><leader><leader>",
                        function() Snacks.picker({ layout = "vscode" }) end,
                        desc = "Main Picker",
                        mode = { "n" },
                },
                { -- FILES
                        "<leader><leader>f",
                        function() Snacks.picker.files({ layout = "vertical", hidden = true }) end,
                        desc = "File Picker",
                        mode = { "n" },
                },
                { -- KEYMAPS
                        "<leader><leader>k",
                        function() Snacks.picker.keymaps({ layout = "dropdown" }) end,
                        desc = "Keymap Picker",
                        mode = { "n" },
                },
                { -- GREP
                        "<leader><leader>w",
                        function() Snacks.picker.grep({ layout = "vertical" }) end,
                        desc = "Grep Picker",
                        mode = { "n" },
                },
                { -- GREP WORD
                        "<leader><leader>W",
                        function() Snacks.picker.grep_word({ layout = "vertical" }) end,
                        desc = "Grep Word",
                        mode = { "n" },
                },
                { -- REGISTERS
                        "<leader><leader>R",
                        function() Snacks.picker.registers({ layout = "vertical" }) end,
                        desc = "Register Picker",
                        mode = { "n" },
                },
                { -- HIGHLIGHTS
                        "<leader><leader>h",
                        function() Snacks.picker.highlights({ layout = "default" }) end,
                        desc = "Highlight Picker",
                        mode = { "n" },
                },
                { -- LAZY
                        "<leader><leader>l",
                        function() Snacks.picker.lazy({ layout = "dropdown" }) end,
                        desc = "Lazy Picker",
                        mode = { "n" },
                },
                { -- BUFFERS
                        "<leader><leader>b",
                        function()
                                Snacks.picker.buffers({
                                        on_show = function() vim.cmd.stopinsert() end,
                                        layout  = "default",
                                        format  = "buffer",
                                        hidden  = false,
                                        win     = {
                                                input = { keys = { ["d"] = "bufdelete" } },
                                                -- list   = { keys  = { ["Backspace"]  = "bufdelete" } },
                                        },
                                })
                        end,
                        desc = "Buffer Picker",
                        mode = { "n" },
                },
                { -- UNDO
                        "<leader><leader>u",
                        function()
                                Snacks.picker.undo({
                                        on_show = function() vim.cmd.stopinsert() end,
                                        layout  = "default",
                                        format  = "buffer",
                                        hidden  = false,
                                        win     = {
                                                -- input  = { keys  = { ["Backspace"]  = "bufdelete" } },
                                                -- list   = { keys  = { ["Backspace"]  = "bufdelete" } },
                                        },
                                })
                        end,
                        desc = "Buffer Picker",
                        mode = { "n" },
                },

                -- LSP PICKERS
                { -- REFERENCES
                        prefix .. "r",
                        function()
                                Snacks.picker.lsp_references({
                                        layout  = "vertical",
                                        on_show = function() vim.cmd.stopinsert() end,
                                })
                        end,
                        desc = "Show References",
                        mode = { "n" },
                },
                { -- IMPLEMENTATIONS
                        prefix .. "i",
                        function()
                                Snacks.picker.lsp_implementations({
                                        layout  = "vertical",
                                        on_show = function() vim.cmd.stopinsert() end,
                                })
                        end,
                        desc = "Show Implementations",
                        mode = { "n" },
                },
                { -- DEFINITIONS
                        prefix .. "d",
                        function()
                                Snacks.picker.lsp_definitions({
                                        layout  = "vertical",
                                        on_show = function() vim.cmd.stopinsert() end,
                                })
                        end,
                        desc = "Show Definitions",
                        mode = { "n" },
                },
                { -- DECLARATIONS
                        prefix .. "D",
                        function()
                                Snacks.picker.lsp_declarations({
                                        layout  = "vertical",
                                        on_show = function() vim.cmd.stopinsert() end,
                                })
                        end,
                        desc = "Show Declarations",
                        mode = { "n" },
                },
                { -- SYMBOLS
                        prefix .. "s",
                        function()
                                Snacks.picker.lsp_symbols({
                                        layout  = "vertical",
                                        on_show = function() vim.cmd.stopinsert() end,
                                })
                        end,
                        desc = "Show LSP Symbols",
                        mode = { "n" },
                },
                { -- WORKSPACE SYMBOLS
                        prefix .. "S",
                        function()
                                Snacks.picker.lsp_workspace_symbols({
                                        layout  = "vertical",
                                        on_show = function() vim.cmd.stopinsert() end,
                                })
                        end,
                        desc = "Show Workspace Symbols",
                        mode = { "n" },
                },
                { -- DIAGNOSTICS BUFFER
                        "<leader><leader>o",
                        function()
                                Snacks.picker.diagnostics_buffer({
                                        layout  = "vertical",
                                        on_show = function() vim.cmd.stopinsert() end,
                                })
                        end,
                        desc = "Show Buffer Diagnostics",
                        mode = { "n" },
                },
                { -- DIAGNOSTICS WORKSPACE
                        "<leader><leader>O",
                        function()
                                Snacks.picker.diagnostics({
                                        layout  = "vertical",
                                        on_show = function() vim.cmd.stopinsert() end,
                                })
                        end,
                        desc = "Show Workspace Symbols",
                        mode = { "n" },
                },
        },
        opts     = {
                words        = { enabled = false },
                quickfile    = { enabled = true },
                lazygit      = { enabled = true },
                input        = { enabled = true },
                win          = {
                        border = vim.g.borderStyle,
                        wo     = {
                                signcolumn     = "no",
                                statuscolumn   = " ",
                                winbar         = "",
                                number         = false,
                                relativenumber = false,
                                cursorcolumn   = false,
                        },
                },
                statuscolumn = {
                        enabled = false,
                        left    = { "git", "sign" },
                        right   = { "fold" },
                        folds   = { open = true, git_hl = false },
                        git     = { pattern = { "GitSign", "MiniDiffSign" } },
                        refresh = 50,
                },
                styles       = {
                        notification_history = { border = vim.g.borderStyleNone, height = 0.9, width = 0.9 },
                        input                = {
                                backdrop = true,
                                border   = vim.g.borderStyle,
                                row      = math.ceil(vim.o.lines / 2) - 8,
                                wo       = {
                                        cursorline   = false,
                                        winhighlight =
                                        "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
                                },
                        },
                        notification         = {
                                border  = vim.g.borderStyle,
                                wo      = { winblend = 40 },
                                icons   = icons.notifier,
                                enabled = true,
                                timeout = 2000,
                                style   = "minimal",
                        },
                        blame_line           = {
                                backdrop = true,
                                width    = 0.6,
                                height   = 0.6,
                                border   = vim.g.borderStyle,
                                title    = " 󰆽 Git blame ",
                        },
                },
                scope        = {
                        treesitter = {
                                blocks = {
                                        enabled     = true,
                                        textobjects = {
                                                ii = {
                                                        min_size   = 1,
                                                        cursor     = true,
                                                        edge       = true,
                                                        treesitter = { blocks = { enable = true } },
                                                },
                                                ai = {
                                                        min_size   = 1,
                                                        cursor     = true,
                                                        treesitter = { blocks = { enable = true } },
                                                },
                                        },
                                },
                        },
                },
                indent       = {
                        animate = { enabled = false },
                        char    = { vertical = require("core.icons").misc.vertical_bar },
                        indent  = { enabled = false },
                        scope   = {
                                enabled      = false,
                                char         = require("core.icons").misc.vertical_bar,
                                underline    = true,
                                only_current = true,
                                hl           = "SnacksIndentScope",
                        },
                },
                notifier     = {
                        icons   = icons.notifier,
                        style   = "minimal",
                        enabled = true,
                        timeout = 2000,
                },
                picker       = {
                        prompt    = " > ",
                        ui_select = true,
                        hidden    = true,
                        ignored   = true,
                        formats   = { file = { filename_only = true } },
                        layout    = { preset = "default" },
                        win       = {
                                input = {
                                        keys = {
                                                ["<Esc>"] = { "close", mode = { "i", "n" } },
                                                ["h"]     = { "toggle_hidden", mode = { "n" } },
                                                ["l"]     = { "confirm", mode = { "n" } },
                                                ["J"]     = { "preview_scroll_down", mode = { "i", "n" } },
                                                ["K"]     = { "preview_scroll_up", mode = { "i", "n" } },
                                                ["H"]     = { "preview_scroll_left", mode = { "i", "n" } },
                                                ["L"]     = { "preview_scroll_right", mode = { "i", "n" } },
                                        },
                                },
                        },
                        layouts   = {
                                vscode   = {
                                        preview = false,
                                        layout  = {
                                                backdrop  = true,
                                                row       = 1,
                                                width     = 0.3,
                                                height    = 0.45,
                                                min_width = 60,
                                                border    = "none",
                                                box       = "vertical",
                                                { win = "input",   height = 1,          border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
                                                { win = "list",    border = "bottom" },
                                                { win = "preview", title = "{preview}", border = "rounded" },
                                        },
                                },
                                select   = {
                                        preview = false,
                                        layout  = {
                                                backdrop   = true,
                                                width      = 0.5,
                                                min_width  = 80,
                                                height     = 0.4,
                                                min_height = 10,
                                                box        = "vertical",
                                                border     = "rounded",
                                                title      = "{title}",
                                                title_pos  = "center",
                                                { win = "input",   height = 1,          border = "bottom" },
                                                { win = "list",    border = "none" },
                                                { win = "preview", title = "{preview}", height = 0.4,     border = "top" },
                                        },
                                },
                                vertical = {
                                        layout = {
                                                backdrop   = true,
                                                width      = 0.8,
                                                height     = 0.95,
                                                min_width  = 70,
                                                min_height = 30,
                                                box        = "vertical",
                                                border     = "single",
                                                title      = "{title} {live} {flags}",
                                                title_pos  = "center",
                                                { win = "list",    border = "none" },
                                                { win = "input",   height = 1,          border = "bottom" },
                                                { win = "preview", title = "{preview}", height = 0.6,     border = "top" },
                                        },
                                },
                                default  = {
                                        layout = {
                                                box       = "horizontal",
                                                width     = 0.9,
                                                min_width = 120,
                                                height    = 0.9,
                                                {
                                                        box    = "vertical",
                                                        border = "rounded",
                                                        title  = "{title} {live} {flags}",
                                                        { win = "input", height = 1,     border = "bottom" },
                                                        { win = "list",  border = "none" },
                                                },
                                                { win = "preview", title = "{preview}", border = "rounded", width = 0.7 },
                                        },
                                },
                                dropdown = {
                                        layout = {
                                                backdrop  = true,
                                                row       = 1,
                                                width     = 0.5,
                                                height    = 0.9,
                                                min_width = 80,
                                                border    = "none",
                                                box       = "vertical",
                                                {
                                                        box       = "vertical",
                                                        border    = "rounded",
                                                        title     = "{title} {live} {flags}",
                                                        title_pos = "center",
                                                        { win = "input", height = 1,     border = "bottom" },
                                                        { win = "list",  border = "none" },
                                                        -- { win  = "preview", title  = "{preview}", height  = 0.6,     border  = "rounded" },
                                                },
                                        },
                                },
                                sidebar  = {
                                        preview = false,
                                        layout  = {
                                                backdrop  = true,
                                                width     = 20,
                                                min_width = 20,
                                                height    = 0,
                                                position  = "left",
                                                border    = "none",
                                                box       = "vertical",
                                                {
                                                        win       = "input",
                                                        height    = 1,
                                                        border    = "rounded",
                                                        title     = "{title} {live} {flags}",
                                                        title_pos = "center",
                                                },
                                                { win = "list",    border = "none" },
                                                { win = "preview", title = "{preview}", height = 0.4, border = "top" },
                                        },
                                },
                        },
                        icons     = {
                                diagnostics = icons.diagnostics,
                                kinds       = icons.symbol_kinds,
                        },
                },
                image        = {
                        enabled  = false,
                        formats  = { "png", "jpg", "jpeg", "gif", "bmp", "webp", "tiff", "heic", "avif", "mp4", "mov", "avi", "mkv", "webm", "pdf" },
                        force    = false,
                        doc      = {
                                enabled    = true,
                                inline     = true,
                                float      = true,
                                max_width  = 80,
                                max_height = 40,

                                conceal    = function(lang, type)
                                        return type == "math"
                                end,
                        },
                        img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
                        wo       = {
                                wrap           = false,
                                number         = false,
                                relativenumber = false,
                                cursorcolumn   = false,
                                signcolumn     = "no",
                                foldcolumn     = "0",
                                list           = false,
                                spell          = false,
                                statuscolumn   = "",
                        },
                        cache    = vim.fn.stdpath("cache") .. "/snacks/image",
                        debug    = {
                                request   = false,
                                convert   = false,
                                placement = false,
                        },
                        env      = {},
                        icons    = {
                                math  = "󰪚 ",
                                chart = "󰄧 ",
                                image = " ",
                        },
                        convert  = {
                                notify  = true,
                                mermaid = function()
                                        local theme = vim.o.background == "light" and "neutral" or "dark"
                                        return { "-i", "{src}", "-o", "{file}", "-b", "transparent", "-t", theme,
                                                "-s", "{scale}" }
                                end,
                                magick  = {
                                        default = { "{src}[0]", "-scale", "1920x1080>" },
                                        vector  = { "-density", 192, "{src}[0]" },
                                        math    = { "-density", 192, "{src}[0]", "-trim" },
                                        pdf     = { "-density", 192, "{src}[0]", "-background", "white", "-alpha", "remove", "-trim" },
                                },
                        },
                        math     = {
                                enabled = true,
                                typst   = {
                                        tpl = [[
                                                        #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
                                                        #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
                                                        #set text(size: 12pt, fill: rgb("${color}"))
                                                        ${header}
                                                        ${content}
                                                ]],
                                },
                                latex   = {
                                        font_size = "Large",
                                        packages  = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
                                        tpl       = [[
                                                        \documentclass[preview,border=0pt,varwidth,12pt]{standalone}
                                                        \usepackage{${packages}}
                                                        \begin{document}
                                                        ${header}
                                                        { \${font_size} \selectfont
                                                        \color[HTML]{${color}}
                                                        ${content}}
                                                        \end{document}
                                                ]],
                                },
                        },
                },
                dashboard    = {
                        formats  = {
                                key = function(item)
                                        return {
                                                { "[",      hl = "DropBarKindNumber" },
                                                { item.key, hl = "DropBarKindCall" },
                                                { "]",      hl = "DropBarKindNumber" },
                                        }
                                end,
                        },
                        sections = {
                                { -- LOGO
                                        text    = {
                                                {
                                                        [[
  ▄████▄       ░░░░░    ░░░░░    ░░░░░    ░░░░░
 ███▄█▀       ░ ▄░ ▄░  ░ ▄░ ▄░  ░ ▄░ ▄░  ░ ▄░ ▄░
█████  █  █   ░░░░░░░  ░░░░░░░  ░░░░░░░  ░░░░░░░
 █████▄       ░░░░░░░  ░░░░░░░  ░░░░░░░  ░░░░░░░
   ████▀      ░ ░ ░ ░  ░ ░ ░ ░  ░ ░ ░ ░  ░ ░ ░ ░
]],
                                                },
                                                hl = "Title",
                                        },
                                        align   = "center",
                                        padding = 2,
                                },
                                { -- NEW FILE
                                        text    = {
                                                { "󰻭  ", hl = button },
                                                { "New file", hl = label, width = 45 },
                                                { "[", hl = button },
                                                { "n", hl = label },
                                                { "]", hl = button },
                                        },
                                        key     = "n",
                                        action  = "<cmd> enew <BAR> startinsert <CR>",
                                        padding = 1,
                                        align   = "center",
                                },
                                { -- RECENT FILES
                                        text    = {
                                                { "󰕁  ", hl = button },
                                                { "Recent files", hl = label, width = 45 },
                                                { "[", hl = button },
                                                { "r", hl = label },
                                                { "]", hl = button },
                                        },
                                        key     = "r",
                                        action  = function() Snacks.picker.recent({ layout = "vertical" }) end,
                                        padding = 1,
                                        align   = "center",
                                },
                                { -- FIND FILE
                                        text    = {
                                                { "󰱽  ", hl = button },
                                                { "Find file", hl = label, width = 45 },
                                                { "[", hl = button },
                                                { "f", hl = label },
                                                { "]", hl = button },
                                        },
                                        action  = function() Snacks.picker.files({ layout = "vertical" }) end,
                                        key     = "f",
                                        padding = 1,
                                        align   = "center",
                                },
                                { -- FIND TEXT
                                        text    = {
                                                { "󰦪  ", hl = button },
                                                { "Find text", hl = label, width = 45 },
                                                { "[", hl = button },
                                                { "w", hl = label },
                                                { "]", hl = button },
                                        },
                                        action  = function() Snacks.picker.grep({ layout = "vertical" }) end,
                                        key     = "w",
                                        padding = 1,
                                        align   = "center",
                                },
                                { -- YAZI
                                        text    = {
                                                { "󰦪  ", hl = button },
                                                { "Yazi", hl = label, width = 45 },
                                                { "[", hl = button },
                                                { "y", hl = label },
                                                { "]", hl = button },
                                        },
                                        action  = "<cmd>Yazi<CR>",
                                        key     = "y",
                                        padding = 1,
                                        align   = "center",
                                },
                                { -- RESTORE SESSION
                                        text    = {
                                                { "󰦛  ", hl = button },
                                                { "Restore session", hl = label, width = 45 },
                                                { "[", hl = button },
                                                { "s", hl = label },
                                                { "]", hl = button },
                                        },
                                        key     = "s",
                                        action  = [[<cmd> lua require("persistence").load({ last  = false }) <cr>]],
                                        padding = 1,
                                        align   = "center",
                                },
                                { -- CONFIG
                                        text    = {
                                                { "󱤸  ", hl = button },
                                                { "Config", hl = label, width = 45 },
                                                { "[", hl = button },
                                                { "c", hl = label },
                                                { "]", hl = button },
                                        },
                                        key     = "c",
                                        action  = function() Snacks.picker.files() end,
                                        padding = 1,
                                        align   = "center",
                                },
                                { -- LAZY
                                        text    = {
                                                { "󰏗  ", hl = button },
                                                { "Lazy", hl = label, width = 45 },
                                                { "[", hl = button },
                                                { "l", hl = label },
                                                { "]", hl = button },
                                        },
                                        key     = "l",
                                        action  = "<cmd> Lazy <CR>",
                                        padding = 1,
                                        align   = "center",
                                },
                                { -- UPDATE
                                        text    = {
                                                { "󱧕  ", hl = button },
                                                { "Update plugins", hl = label, width = 45 },
                                                { "[", hl = button },
                                                { "u", hl = label },
                                                { "]", hl = button },
                                        },
                                        key     = "u",
                                        action  = "<cmd> Lazy update <CR>",
                                        padding = 1,
                                        align   = "center",
                                },
                                { -- QUIT
                                        text    = {
                                                { "󰈆  ", hl = button },
                                                { "Quit", hl = label, width = 45 },
                                                { "[", hl = button },
                                                { "q", hl = label },
                                                { "]", hl = button },
                                        },
                                        key     = "q",
                                        action  = "<cmd> qa <CR>",
                                        padding = 2,
                                        align   = "center",
                                },
                                { -- PANE
                                        pane    = 1,
                                        section = "startup",
                                },
                        },
                },
        },
}
