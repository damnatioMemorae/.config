icons = require("core.icons").diagnostics.HINT

return {
        "rachartier/tiny-inline-diagnostic.nvim",
        event    = "VeryLazy",
        opts     = {
                signs   = {
                        left         = "",
                        right        = "",
                        diag         = icons,
                        arrow        = "",
                        up_arrow     = " ",
                        vertical     = " │",
                        vertical_end = " └",
                },
                blend   = { factor = 0.1 },
                options = {
                        show_source                  = true,
                        throttle                     = 20,
                        softwrap                     = 30,
                        multiple_diag_under_cursor   = true,
                        multilines                   = {
                                enabled          = true,
                                trim_whitespaces = false,
                        },
                        show_all_diags_on_cursorline = true,
                        enable_on_insert             = false,
                        enable_on_select             = false,
                        overwrite_events             = nil,
                        overflow                     = { mode = "wrap" },
                        break_line                   = { enabled = false, after = 30 },
                        virt_texts                   = { priority = 2000 },
                        format                       = function(diagnostic)
                                return diagnostic.message .. " [" .. diagnostic.source .. "]"
                        end,
                },
        },
}
