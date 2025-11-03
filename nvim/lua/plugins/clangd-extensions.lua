return {
        "p00f/clangd_extensions.nvim",
        ft   = { "c", "cpp", "objc", "objcpp", "h", "hpp", "hh", "hxx" },
        opts = {

                inlay_hints  = {
                        inline                 = true,
                        only_current_line      = false,
                        show_parameter_hints   = true,
                        parameter_hints_prefix = "<- ",
                        other_hints_prefix     = "=> ",
                        max_len_align          = false,
                        max_len_align_padding  = 1,
                        right_align            = false,
                        right_align_padding    = 7,
                        highlight              = "LspInlayHint",
                        priority               = 100,
                },
                ast          = {
                        role_icons = {
                                type                  = "",
                                declaration           = "",
                                expression            = "",
                                specifier             = "",
                                statement             = "",
                                ["template argument"] = "",
                        },

                        kind_icons = {
                                Compound             = "",
                                Recovery             = "",
                                TranslationUnit      = "",
                                PackExpansion        = "",
                                TemplateTypeParm     = "",
                                TemplateTemplateParm = "",
                                TemplateParamObject  = "",
                        },

                        highlights = {
                                detail = "Comment",
                        },
                },
                memory_usage = {
                        border = vim.g.borderStyle
                },
                symbol_info  = {
                        border = vim.g.borderStyle
                },
        },
}
