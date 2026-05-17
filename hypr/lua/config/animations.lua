hl.config({ animations = { enabled = true, workspace_wraparound = false } })

local curves = {
        { "linear",        { type = "bezier", points = { { 0.00, 0.00 }, { 1.00, 1.00 } } } },
        { "md3_standard",  { type = "bezier", points = { { 0.20, 0.00 }, { 0.00, 1.00 } } } },
        { "md3_decel",     { type = "bezier", points = { { 0.05, 0.70 }, { 0.10, 1.00 } } } },
        { "md3_accel",     { type = "bezier", points = { { 0.30, 0.00 }, { 0.80, 0.15 } } } },
        { "overshot",      { type = "bezier", points = { { 0.05, 0.90 }, { 0.10, 1.10 } } } },
        { "crazyshot",     { type = "bezier", points = { { 0.10, 1.50 }, { 0.76, 0.92 } } } },
        { "hyprnostretch", { type = "bezier", points = { { 0.05, 0.90 }, { 0.10, 1.00 } } } },
        { "menu_decel",    { type = "bezier", points = { { 0.10, 1.00 }, { 0.00, 1.00 } } } },
        { "menu_accel",    { type = "bezier", points = { { 0.38, 0.04 }, { 1.00, 0.07 } } } },
        { "easeInOutCirc", { type = "bezier", points = { { 0.85, 0.00 }, { 0.15, 1.00 } } } },
        { "easeOutCirc",   { type = "bezier", points = { { 0.00, 0.55 }, { 0.45, 1.00 } } } },
        { "easeOutExpo",   { type = "bezier", points = { { 0.16, 1.00 }, { 0.30, 1.00 } } } },
        { "softAcDecel",   { type = "bezier", points = { { 0.26, 0.26 }, { 0.15, 1.00 } } } },
        { "md2",           { type = "bezier", points = { { 0.40, 0.00 }, { 0.20, 1.00 } } } },
}
for _, curve in ipairs(curves) do
        hl.curve(curve[1], curve[2])
end

local animations = {
        { "windowsIn",           true, 5, "md3_decel", "slide" },
        { "windowsOut",          true, 5, "md3_accel", "slide" },

        { "layersIn",            true, 5, "md3_decel", "slide" },
        { "layersOut",           true, 5, "md3_accel", "slide" },

        { "fadeLayersIn",        true, 5, "md3_decel" },
        { "fadeLayersOut",       true, 5, "md3_accel" },

        { "workspacesIn",        true, 5, "md3_decel", "slide top" },
        { "workspacesOut",       true, 5, "md3_accel", "slide bottom" },

        { "specialWorkspaceIn",  true, 5, "md3_decel", "slide right" },
        { "specialWorkspaceOut", true, 5, "md3_accel", "slide left" },
}
for _, animation in ipairs(animations) do
        hl.animation({
                leaf    = animation[1],
                enabled = animation[2],
                speed   = animation[3],
                bezier  = animation[4],
                style   = animation[5],
        })
end
