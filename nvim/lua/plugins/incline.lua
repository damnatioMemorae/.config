return {
        "b0o/incline.nvim",
        event  = "BufReadPre",
        opts   = {
                debounce_threshold = 0,
                hide               = { only_win = false },
                window             = {
                        padding = 0,
                        margin  = { horizontal = 0 },
                        overlap = { winbar = true },
                        width   = "fit",
                },
                highlight          = {
                        groups = {
                                InclineNormal   = { default = true, group = "LspInlayHint" },
                                InclineNormalNC = { default = true, group = "LspInlayHint" },
                        },
                },
                render             = function(props)
                        local devicons   = require("nvim-web-devicons")
                        local filename   = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t:r")
                        local ft_icon, _ = devicons.get_icon_color()

                        if filename == "" then
                                filename = "[No Name]"
                        end

                        local function getDiff()
                                local file = vim.fn.expand("%:p")
                                if file == "" then
                                        print("no file")
                                        return
                                end

                                local res = vim.system({ "git", "diff", "--numstat", "HEAD", "--", file },
                                                       { text = true }):wait()

                                local add, del = res.stdout:match("^(%d+)%s+(%d+)")
                                add = tonumber(add) or 0
                                del = tonumber(del) or 0

                                local changed = math.min(add, del)

                                -- local diff = vim.split(string.format("%d+ %d~ %d-", add, changed, del), " ")
                                local diff = { add, changed, del }

                                return vim.iter(diff)
                                           :map(function(item)
                                                   return {
                                                           -- { string.format("%d", item) .. "+", group = "DiffAdded" },
                                                           -- { string.format("%d", item) .. "~", group = "DiffChanged" },
                                                           -- { string.format("%d", item) .. "-", group = "DiffRemoved" },
                                                           -- { string.format("%d+ ", item), group = "DiffAdded" },
                                                           -- { string.format("%d~ ", item), group = "DiffChanged" },
                                                           -- { string.format("%d- ", item), group = "DiffRemoved" },
                                                           { string.format("%s+ ", item), group = "DiffAdded" },
                                                           { string.format("%s~ ", item), group = "DiffChanged" },
                                                           { string.format("%s- ", item), group = "DiffRemoved" },
                                                   }
                                           end)
                                           :totable()
                        end

                        local function getPath()
                                local arrow = " " .. Icons.Arrows.rightBig .. " "
                                local path  = vim.split(vim.fn.expand("%:."), "/")
                                local parts = vim.list_slice(path, 1, #path - 1)

                                return vim.iter(parts)
                                           :enumerate()
                                           :map(function(i, item)
                                                   return {
                                                           { Icons.Kinds.Folder, group = "Directory" },
                                                           { " " .. item,        group = "Comment" },
                                                           {
                                                                   i < #parts and arrow or " ",
                                                                   group = "Comment",
                                                           },
                                                   }
                                           end)
                                           :totable()
                        end

                        local function getFt()
                                local label = { { filename, group = "Comment" } }

                                if vim.bo[props.buf].modified then
                                        label[#label + 1] = { "*", group = "Special" }
                                end

                                return label
                        end

                        local function getDiagnostic()
                                local diag   = vim.diagnostic
                                local groups = { "error", "warn", "hint" }

                                return vim.iter(groups)
                                           :map(function(severity)
                                                   local count = #diag.get(props.buf, {
                                                           severity = diag.severity[string.upper(severity)] })

                                                   return { count .. " ", group = "DiagnosticSign" .. severity }
                                           end)
                                           :totable()
                        end

                        local function breadCrumbs(source)
                                local ok, dropbar = pcall(require, "dropbar.sources")
                                if not ok or not props.focused then
                                        return {}
                                end
                                local arrow   = " " .. Icons.Arrows.rightBig .. " "
                                local symbols = dropbar[source].get_symbols(props.buf, 0, vim.api.nvim_win_get_cursor(0))

                                return vim.iter(symbols or {})
                                           :enumerate()
                                           :map(function(i, item)
                                                   return {
                                                           { item._.icon, group = item._.icon_hl },
                                                           { item._.name, group = item._.name_hl },
                                                           {
                                                                   i < #symbols and arrow or " ",
                                                                   group = "Comment",
                                                           },
                                                   }
                                           end)
                                           :totable()
                        end

                        return {
                                { " " },
                                { ft_icon },
                                -- { breadCrumbs("lsp") },
                                { getDiff() },
                                { getPath() },
                                -- { breadCrumbs("path") },
                                { getDiagnostic() },
                                { getFt() },
                                { " " },
                        }
                end,
        },
        config = function(_, opts)
                require("incline").setup(opts)
        end,
}
