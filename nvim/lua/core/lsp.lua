------------------------------------------------------------------------------------------------------------------------
-- LSP SERVERS

local icons      = require("core.icons")
local lspServers = {
        "asm_lsp",
        "basedpyright",
        "bashls",
        "biome",
        "clangd",
        "cmake",
        "css_variables",
        "emmet",
        "emmet-language-server",
        "glsl_analyzer",
        "gopls",
        "hyprls",
        "jsonls",
        "kotlin_lsp",
        "ltex",
        "lua_ls",
        "pylsp",
        "qmlls",
        "qmlls",
        "ruff",
        "rust_analyzer",
        "superhtml",
        "ts_ls",
        "yamlls",
}

vim.lsp.config("*", { root_markers = { ".git" } })

vim.lsp.enable(lspServers)

------------------------------------------------------------------------------------------------------------------------
-- DIAGNOSTICS

local numbers = {
        text  = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN]  = "",
                [vim.diagnostic.severity.INFO]  = "",
                [vim.diagnostic.severity.HINT]  = "",
        },
        numhl = {
                [vim.diagnostic.severity.ERROR] = "ErrorMsg",
                [vim.diagnostic.severity.WARN]  = "WarningMsg",
                [vim.diagnostic.severity.INFO]  = "DiagnosticInfo",
                [vim.diagnostic.severity.HINT]  = "DiagnosticHint",
        },
}

vim.diagnostic.config({
        signs            = numbers,
        jump             = { float = false },
        virtual_text     = false,
        update_in_insert = false,
        severity_sort    = true,
})

------------------------------------------------------------------------------------------------------------------------
-- HANDLERS

local borders                           = icons.misc.Borders
local originalRenameHandler             = vim.lsp.handlers["textDocument/rename"]
vim.lsp.handlers["textDocument/rename"] = function(err, result, ctx, config)
        originalRenameHandler(err, result, ctx, config)
        if err or not result then return end

        local changes      = result.changes or result.documentChanges or {}
        local changedFiles = vim.iter(vim.tbl_keys(changes))
                   :filter(function(file) return #changes[file] > 0 end)
                   :map(function(file) return "- " .. vim.fs.basename(file) end)
                   :totable()
        local changeCount  = 0
        for _, change in pairs(changes) do
                changeCount = changeCount + #(change.edits or change)
        end

        local pluralS = changeCount > 1 and "s" or ""
        local msg     = ("[%d] instance%s"):format(changeCount, pluralS)
        if #changedFiles > 1 then
                msg = ("**%s in [%d] files**\n%s"):format(msg, #changedFiles, table.concat(changedFiles, "\n"))
        end
        vim.notify(msg, nil, { title = "Renamed with LSP", icon = "󰑕" })

        if #changedFiles > 1 then vim.cmd.wall() end
end

local hover       = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
        return hover{
                border     = borders,
                title      = "Hover",
                wrap       = false,
                max_height = math.floor(vim.o.lines * 0.5),
                max_width  = math.floor(vim.o.columns * 0.6),
        }
end

local signature_help       = vim.lsp.buf.signature_help
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.signature_help = function()
        return signature_help{
                border     = borders,
                title      = "Signature Help",
                wrap       = false,
                max_height = math.floor(vim.o.lines * 0.5),
                max_width  = math.floor(vim.o.columns * 0.6),
        }
end

------------------------------------------------------------------------------------------------------------------------
-- LSP PROGRESS

local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
        callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                local value  = ev.data.params.value
                if not client or type(value) ~= "table" then
                        return
                end
                local p = progress[client.id]

                for i = 1, #p + 1 do
                        if i == #p + 1 or p[i].token == ev.data.params.token then
                                p[i] = {
                                        token = ev.data.params.token,
                                        msg   = ("[%3d%%] %s%s"):format(
                                                value.kind == "end" and 100 or value.percentage or 100,
                                                value.title or "",
                                                value.message and (" **%s**"):format(value.message) or ""
                                        ),
                                        done  = value.kind == "end",
                                }
                                break
                        end
                end

                local msg           = {}
                progress[client.id] = vim.tbl_filter(function(v) return table.insert(msg, v.msg) or not v.done end, p)

                local spinner = icons.misc.Spinner
                vim.notify(table.concat(msg, "\n"), "info", {
                        id    = "lsp_progress",
                        title = client.name,
                        opts  = function(notif)
                                notif.icon = #progress[client.id] == 0 and icons.notifier.info
                                           ---@diagnostic disable-next-line: undefined-field
                                           or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                        end,
                })
        end,
})
