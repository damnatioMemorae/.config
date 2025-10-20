return {
        "stevearc/overseer.nvim",
        event   = "VeryLazy",
        enabled = false,
        config  = function()
                require("overseer").setup({
                        dap = false,
                })
        end,
}
