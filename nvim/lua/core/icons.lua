local M = {}
------------------------------------------------------------------------------------------------------------------------

local squareFilled = "■"
local squareEmpty  = "󰝣"

-- DIAGNOSTICS
M.diagnostics = {
        ERROR = squareFilled,
        WARN  = squareFilled,
        INFO  = squareFilled,
        HINT  = squareFilled,

        Error = squareFilled,
        Warn  = squareFilled,
        Info  = squareFilled,
        Hint  = squareFilled,

        errorMd = "󰅙 ",
        warnMd  = " ",
        infoMd  = "󰀨 ",
        hintMd  = "󰁨 ",

        lightbulb = "󱠀",
}

-- NOTIFIER
M.notifier = {
        error = M.diagnostics.ERROR,
        warn  = M.diagnostics.WARN,
        info  = M.diagnostics.INFO,
        debug = M.diagnostics.HINT,
        trace = M.diagnostics.HINT,
}

-- FOLDING
M.arrows = {
        close = "+",
        open  = "-",
        -- close = "󰜄",
        -- open  = "󰛲",
        right = "",
        left  = "",
        up    = "",
        down  = "",
}

-- LSP KINDS
M.symbol_kinds = {
        Array             = "󰅪 ",
        Boolean           = " ",
        BreakStatement    = "󰙧 ",
        Call              = "󰃷 ",
        CaseStatement     = "󱃙 ",
        Class             = " ",
        Color             = " ",
        Component         = "󰅴 ",
        Constant          = " ",
        Constructor       = " ",
        ContinueStatement = "→ ",
        Copilot           = " ",
        Declaration       = "󰙠 ",
        Delete            = "󰢤 ",
        DoStatement       = "󰑖 ",
        Enum              = " ",
        EnumMember        = " ",
        Event             = " ",
        Field             = " ",
        File              = " ",
        Folder            = " ",
        ForStatement      = "󰑖 ",
        Fragment          = "󰅴 ",
        Function          = " ",
        H1Marker          = "󰉫 ",
        H2Marker          = "󰉬 ",
        H3Marker          = "󰉭 ",
        H4Marker          = "󰉮 ",
        H5Marker          = "󰉯 ",
        H6Marker          = "󰉰 ",
        Identifier        = " ",
        IfStatement       = " ",
        Interface         = " ",
        Key               = " ",
        Keyword           = " ",
        List              = "󰅪 ",
        Log               = " ",
        Lsp               = " ",
        Macro             = " ",
        MarkdownH1        = "󰉫 ",
        MarkdownH2        = "󰉬 ",
        MarkdownH3        = "󰉭 ",
        MarkdownH4        = "󰉮 ",
        MarkdownH5        = "󰉯 ",
        MarkdownH6        = "󰉰 ",
        Method            = " ",
        Module            = " ",
        Namespace         = " ",
        Null              = "󰢤 ",
        Number            = "󰎠 ",
        Object            = " ",
        Operator          = " ",
        Package           = " ",
        Pair              = "󰅪 ",
        Parameter         = " ",
        Property          = " ",
        Reference         = " ",
        Regex             = " ",
        Repeat            = "󰑖 ",
        Scope             = " ",
        Snippet           = " ",
        Specifier         = "󰦪 ",
        Statement         = " ",
        StaticMethod      = " ",
        String            = "󰉾 ",
        Struct            = " ",
        SwitchStatement   = "󰺟 ",
        Terminal          = " ",
        Text              = " ",
        Type              = " ",
        TypeAlias         = " ",
        TypeParameter     = " ",
        Unit              = " ",
        Value             = " ",
        Variable          = " ",
        WhileStatement    = "󰑖 ",
}

M.symbol_kinds_alt = {
        Text          = "󰉿",
        Method        = "󰊕",
        Function      = "󰊕",
        Constructor   = "󰒓",
        Field         = "󰜢",
        Variable      = "󰆦",
        Property      = "󰖷",
        Class         = "󱡠",
        Interface     = "󱡠",
        Struct        = "󱡠",
        Module        = "󰅩",
        Unit          = "󰪚",
        Value         = "󰦨",
        Enum          = "󰦨",
        EnumMember    = "󰦨",
        Keyword       = "󰻾",
        Constant      = "󰏿",
        Snippet       = "󱄽",
        Color         = "󰏘",
        File          = "󰈔",
        Reference     = "󰬲",
        Folder        = "󰉋",
        Event         = "󱐋",
        Operator      = "󰪚",
        TypeParameter = "󰬛",

}

-- MISC
M.misc = {
        Bug            = "",
        Ellipsis       = "…",
        Variable       = "",
        Git            = "",
        Search         = "",
        Vertical_bar   = "▏",
        Prompt         = ">",
        FolderOpen     = "",
        FolderEmpty    = "",
        Borders        = { " ", " ", " ", " ", " ", " ", " ", " " },
        Spinner        = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
        Dashed_bar     = squareFilled,
        definiton      = squareFilled,
        reference      = "󰘷",
        implementation = "󰃐",
}

-- GIT
M.git = {
        Git      = "",
        Added    = squareFilled,
        Modified = squareEmpty,
        Deleted  = squareEmpty,
}

------------------------------------------------------------------------------------------------------------------------
return M
