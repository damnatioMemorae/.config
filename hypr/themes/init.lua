local rgb = require("core.utils").rgb

local cmds = {
        "gsettings set org.gnome.desktop.interface gtk-theme           'catppuccin-mocha-red-standard+default'",
        "gsettings set org.gnome.desktop.interface color-scheme        'prefer-dark'",
        "hyprctl setcursor catppuccin-mocha-red                        20",
        "gsettings set org.gnome.desktop.interface cursor-theme        catppuccin-mocha-red",
        "gsettings set org.gnome.desktop.interface cursor-size         20",
        "gsettings set org.gnome.desktop.interface font-name           'Monocraft 10'",
        "gsettings set org.gnome.desktop.interface document-font-name  'Monocraft 10'",
        "gsettings set org.gnome.desktop.interface monospace-font-name 'Monocraft 10'",
        "gsettings set org.gnome.desktop.interface font-antialiasing   'rgba'",
        "gsettings set org.gnome.desktop.interface font-hinting        'full'",
}
for _, cmd in ipairs(cmds) do
        hl.exec_cmd(cmd)
end

local M = {}
--------------------------------------------------------------------------------------------------------------------------------------------

M.Colors = {
        ivory     = "#dce0e8",
        spark     = "#add8e6",
        rosewater = "#f5e0dc",
        flamingo  = "#f2cdcd",
        pink      = "#f5c2e7",
        mauve     = "#cba6f7",
        red       = "#f38ba8",
        maroon    = "#eba0ac",
        peach     = "#fab387",
        yellow    = "#f9e2af",
        green     = "#a6e3a1",
        teal      = "#94e2d5",
        sky       = "#89dceb",
        sapphire  = "#74c7ec",
        blue      = "#89b4fa",
        lavender  = "#b4befe",
        text      = "#cdd6f4",
        subtext1  = "#bac2de",
        subtext0  = "#a6adc8",
        overlay2  = "#9399b2",
        overlay1  = "#7f849c",
        overlay0  = "#6c7086",
        surface2  = "#585b70",
        surface1  = "#45475a",
        surface0  = "#313244",
        base      = "#1e1e2e",
        mantle    = "#14141f",
        crust1    = "#11111b",
        crust0    = "#0e0e16",
}

M.Groups = {
        BodrerActive   = rgb(M.Colors.text),
        BodrerInactive = rgb(M.Colors.text),

        groupBodrerActive         = rgb(M.Colors.text),
        groupBodrerInactive       = rgb(M.Colors.text),
        groupBodrerActiveLocked   = rgb(M.Colors.text),
        groupBodrerInactiveLocked = rgb(M.Colors.text),
        groupBarText              = rgb(M.Colors.text),
        groupBarActive            = rgb(M.Colors.crust0),
        groupBarInactive          = rgb(M.Colors.mantle),
        groupBarActiveLocked      = rgb(M.Colors.red),
        groupBarInactiveLocked    = rgb(M.Colors.crust0),
}

--------------------------------------------------------------------------------------------------------------------------------------------
return M
