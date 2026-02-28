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
                        local file = "/.luarc.jsonc" or "/.luarc.json" or "nvim/.luarc.jsonc" or "nvim/.luarc.json"

                        if path ~= vim.fn.stdpath("config") or (vim.uv.fs_stat(path .. file)) then
                                client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                                        runtime   = {
                                                version = "LuaJIT",
                                                path    = { "lua/?.lua", "lua/?/init.lua" },
                                        },
                                        workspace = { library = { "$VIMRUNTIME", "${3rd}/luv/library" } },
                                })
                        end
                end
        end,
        --]]
        settings     = {
                Lua = {
                        completion    = {
                                displayContext = 999,
                                callSnippet    = "Both",
                                showWord       = "Fallback",
                                workspaceWord  = true,
                                postfix        = "@",
                                autoRequire    = false,
                        },
                        diagnostics   = { disable = { "trailing-space", "unused-function", "lowercase-global" } },
                        hover         = { enable = true, enumsLimit = 999, previewFields = 99 },
                        hint          = { enable = true, setType = true, arrayIndex = "Disable", semicolon = "Disable" },
                        semantic      = { enable = false, annotation = true, keyword = false, variable = true },
                        typeFormat    = { config = { auto_complete_end = true, auto_complete_table_sep = true, format_line = true } },
                        codeLens      = { enable = false },
                        signatureHelp = { enable = true },
                        format        = { enable = true },
                        telemetry     = { enable = false },
                },
        },
}
