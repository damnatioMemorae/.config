--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local gest = {}
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

gest = {
        { fingers = 4, direction = "down",       action = "close" },
        { fingers = 4, direction = "left",       action = "special",     workspace_name = "magic" },
        { fingers = 3, direction = "horizontal", action = "workspace" },
        { fingers = 3, direction = "pinchout",   action = "float",       mode = "float" },
        { fingers = 3, direction = "pinchin",    action = "float",       mode = "tile" },
        { fingers = 2, direction = "pinch",      action = "cursor_zoom", mode = "live" },
}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

for _, v in ipairs(gest) do
        hl.gesture(v)
end
