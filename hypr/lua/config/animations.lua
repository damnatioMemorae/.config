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
        return hl.curve(curve[1], curve[2])
end

local animations = {
        { "windows",          true,  3,   "md3_decel",   "popin 60%" },
        { "windowsIn",        true,  3,   "md3_decel",   "popin 60%" },
        { "windowsOut",       true,  3,   "md3_accel",   "popin 60%" },
        { "border",           true,  10,  "default" },
        { "fade",             true,  3,   "md3_decel" },
        { "layers",           true,  2,   "linear",      "slide" },
        { "layersIn",         true,  3,   "md3_decel",   "slide" },
        { "layersOut",        true,  3,   "md3_decel",   "slide" },

        { "layersOut",        false, 1.6, "menu_accel" },
        { "fadeLayersIn",     false, 3,   "md3_decel",   "slidevert" },
        { "fadeLayersOut",    false, 3,   "md3_decel",   "slidevert" },
        { "fadeLayersOut",    false, 4.5, "menu_accel" },

        { "workspaces",       false, 1,   "menu_decel",  "slide" },
        { "workspaces",       true,  1,   "softAcDecel", "slide" },
        { "workspaces",       false, 1,   "menu_decel",  "slidefade 15%" },

        { "specialWorkspace", false, 2,   "md3_decel",   "slidefadevert 15%" },
        { "specialWorkspace", false, 3,   "md3_decel",   "slidevert" },
        { "specialWorkspace", true,  2,   "softAcDecel", "slidevert" },
}
for _, animation in ipairs(animations) do
        return hl.animation({
                leaf    = animation[1],
                enabled = animation[2],
                speed   = animation[3],
                bezier  = animation[4],
                style   = animation[5],
        })
end
