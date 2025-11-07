return {
        "necrom4/convy.nvim",
        cmd  = "Convy",
        keys = { { "<leader><leader>c", mode = { "n", "v" }, function() require("convy").show_selector() end } },
        opts = {},
}
