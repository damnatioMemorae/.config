return {
        "echasnovski/mini.surround",
        enabled = true,
        version = false,
        event   = "VeryLazy",
        opts    = {
                custom_surroundings    = nil,
                highlight_duration     = 1000,
                n_lines                = 20,
                silent                 = true,
                search_method          = "cover_or_nearest",
                respect_selection_type = true,
                mappings               = {
                        add            = "ys",
                        delete         = "yd",
                        find           = "yf",
                        find_left      = "yF",
                        highlight      = "yh",
                        replace        = "yr",
                        update_n_lines = "yn",

                        suffix_last    = "h",
                        suffix_next    = "l",
                },
        },
}
