icons = require("core.icons")

return {
        "kosayoda/nvim-lightbulb",
        event = "LspAttach",
        opts  = {
                priority        = 2000,
                link_highlights = true,
                code_lenses     = true,
                validate_config = "always",
                sign            = {
                        enabled   = true,
                        text      = icons.diagnostics.lightbulb,
                        lens_text = icons.diagnostics.Info,
                        hl        = "LightBulbSign",
                },
                virtual_text    = {
                        enabled   = true,
                        text      = " " .. icons.diagnostics.lightbulb,
                        lens_text = icons.diagnostics.Info,
                        pos       = "eol",
                        hl_mode   = "combine",
                        hl        = "LightBulbSign",
                },
                status_text = {
                        enabled = true
                },
                autocmd         = {
                        enabled    = true,
                        updatetime = 1,
                },
        },
}
