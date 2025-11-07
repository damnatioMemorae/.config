return {
        "oribarilan/lensline.nvim",
        enabled = false,
        event   = "LspAttach",
        keys    = { { "<leader>ol", function() require("lensline").toggle_engine() end } },
        config  = function()
                require("lensline").setup({
                        profiles            = {
                                {
                                        name      = "default",
                                        providers = {
                                                { -- DEF
                                                        name    = "definitions",
                                                        enabled = true,
                                                        event   = { "LspAttach", "BufWritePost" },
                                                        handler = function(bufnr, func_info, provider_config, callback)
                                                                local utils = require("lensline.utils")

                                                                utils.get_lsp_definitions(bufnr, func_info,
                                                                                          function(definitions)
                                                                                                  if definitions then
                                                                                                          local count = #
                                                                                                          definitions
                                                                                                          local icon, text

                                                                                                          icon        = "󰃐"
                                                                                                          text        = icon ..
                                                                                                                     " " ..
                                                                                                                     count

                                                                                                          callback({
                                                                                                                  line =
                                                                                                                  func_info.line,
                                                                                                                  text =
                                                                                                                             text
                                                                                                          })
                                                                                                  end
                                                                                          end)
                                                        end,
                                                },
                                                { -- REF
                                                        name    = "references",
                                                        enabled = true,
                                                        event   = { "LspAttach", "BufWritePost" },
                                                        handler = function(bufnr, func_info, provider_config, callback)
                                                                local utils = require("lensline.utils")

                                                                utils.get_lsp_references(bufnr, func_info,
                                                                                         function(references)
                                                                                                 if references then
                                                                                                         local count = #
                                                                                                         references
                                                                                                         local icon, text

                                                                                                         icon        = "■"
                                                                                                         text        = icon ..
                                                                                                                    " " ..
                                                                                                                    count

                                                                                                         callback({
                                                                                                                 line =
                                                                                                                 func_info.line,
                                                                                                                 text =
                                                                                                                            text
                                                                                                         })
                                                                                                 end
                                                                                         end)
                                                        end,
                                                },
                                                { -- IMPL
                                                        name    = "Implementations",
                                                        enabled = true,
                                                        event   = { "LspAttach", "BufWritePost" },
                                                        handler = function(bufnr, func_info, provider_config, callback)
                                                                local utils = require("lensline.utils")

                                                                utils.get_lsp_implementations(bufnr, func_info,
                                                                                              function(implementations)
                                                                                                      if implementations then
                                                                                                              local count = #
                                                                                                              implementations
                                                                                                              local icon, text

                                                                                                              icon        = "■"
                                                                                                              text        = icon ..
                                                                                                                         " " ..
                                                                                                                         count

                                                                                                              callback({
                                                                                                                      line =
                                                                                                                      func_info.line,
                                                                                                                      text =
                                                                                                                                 text
                                                                                                              })
                                                                                                      end
                                                                                              end)
                                                        end,
                                                },
                                                { -- FL
                                                        name    = "function_length",
                                                        enabled = true,
                                                        event   = { "BufWritePost", "TextChanged" },
                                                        handler = function(bufnr, func_info, provider_config, callback)
                                                                local utils           = require("lensline.utils")
                                                                local function_lines  = utils.get_function_lines(bufnr,
                                                                                                                 func_info)
                                                                local func_line_count = math.max(0, #function_lines - 1)
                                                                local total_lines     = vim.api.nvim_buf_line_count(
                                                                        bufnr)

                                                                callback({
                                                                        line = func_info.line,
                                                                        text = string.format("[%d/%d]", func_line_count,
                                                                                             total_lines),
                                                                })
                                                        end,
                                                },
                                                { name = "complexity",  enabled = true, min_level = "S" },
                                                { name = "diagnostics", enabled = true, min_level = "WARN" },
                                                { name = "last_author", enabled = true, cache_max_files = 50 },
                                        },
                                        style     = {
                                                separator    = " ",
                                                highlight    = "Comment",
                                                prefix       = "",
                                                placement    = "inline",
                                                use_nerdfont = true,
                                                render       = "focused",
                                        },
                                },
                        },
                        limits              = {
                                exclude_append     = {},
                                exclude_gitignored = true,
                                max_lines          = 1000,
                                max_lenses         = 70,
                        },
                        debounce_ms         = 500,
                        focused_debounce_ms = 150,
                        silence_lsp         = true,
                        debug_mode          = false,
                })
        end,
}
