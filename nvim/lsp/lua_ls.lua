return {
        cmd          = { "lua-language-server" },
        filetypes    = { "lua" },
        root_markers = {
                ".luarc.json",
                ".luarc.jsonc",
                ".luacheckrc",
                ".stylua.toml",
                "stylua.toml",
                "selene.toml",
                "selene.yml",
                ".git",
        },
        ---[[
        on_init      = function(client)
                if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if
                                   path ~= vim.fn.stdpath("config")
                                   and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
                        then
                                return
                        end
                end

                client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                        runtime       = {
                                version = "LuaJIT",
                                path    = {
                                        "lua/?.lua",
                                        "lua/?/init.lua",
                                },
                        },
                        hover         = { enable = true },
                        signatureHelp = { enable = true },
                        telemetry     = { enable = false },
                        workspace     = {
                                checkThirdParty = "Disabled",
                                maxPreload      = 500,
                                library         = {
                                        vim.env.VIMRUNTIME,
                                },
                        },
                })
        end,
        --]]
        settings     = {
                Lua = {
                        completion    = {
                                displayContext = 999,
                                callSnippet    = "Both",
                                keywordSnippet = "Both",
                                showWord       = "Fallback",
                                workspaceWord  = true,
                                postfix        = "@",
                        },
                        diagnostics   = {
                                -- workspaceEvent = "OnChange",
                                workspaceEvent = "OnSave",
                                workspaceDelay = 5000,
                                workspaceRate  = 100,
                                libraryFiles   = "Enable",
                                disable        = { "trailing-space", "unused-function", "lowercase-global" },
                        },
                        hover         = { enable = true, enumsLimit = 999, previewFields = 0 },
                        hint          = { enable = true, setType = true, arrayIndex = "Disable", semicolon = "Sameline" },
                        semantic      = { enable = false, annotation = true, keyword = true, variable = true },
                        typeFormat    = { config = { auto_complete_end = true, auto_complete_table_sep = true, format_line = true } },
                        codeLens      = { enable = true },
                        signatureHelp = { enable = true },
                        format        = { enable = true },
                        telemetry     = { enable = false },
                },
        },
}
