return {
        "mistweaverco/snap.nvim",
        version = "v1.0.3",
        event   = "VeryLazy",
        opts    = {
                timeout           = 5000,
                template          = "default",
                template_filepath = nil,
                output_dir        = "$HOME/Pictures/Screenshots",
                filename_pattern  = "snap_nvim_%t",
                copy_to_clipboard = { image = false, html = false },
                font_settings     = {
                        size        = 10,
                        line_height = 1,
                        default     = { name = "Monocraft", file = nil },
                        bold        = { name = "Monocraft", file = nil },
                        italic      = { name = "Monocraft", file = nil },
                        bold_italic = { name = "Monocraft", file = nil },
                },
        },
        debug   = {
                backend   = "bun",
                log_level = "info",
        },
}
