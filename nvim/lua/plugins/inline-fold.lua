return {
        "malbertzard/inline-fold.nvim",
        event = "VeryLazy",
        opts  = {
                queries            = {
                        lua  = {
                                { pattern = "function([.-])" },
                        },
                        html = {
                                { pattern = 'class="([^"]*)"', placeholder = "@" },
                                { pattern = 'href="(.-)"' },
                                { pattern = 'src="(.-)"' },
                        },
                },
        },
}
