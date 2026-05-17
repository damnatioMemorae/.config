local HOME        = os.getenv("HOME")
local script_path = HOME .. "/.local/share/bin/"

local cmds = {
        -- "hyprshade auto",
        -- "$scrPath/resetxdgportal",
        -- "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
        -- "dbus-update-activation-environment --systemd --all",
        -- "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
        { script_path .. "polkitkdeauth" },
        -- "lua $scrPath/lua/waybar.lua set bottom",
        -- "eww --config ~/.config/eww/bottom-bar/ --restart open-many bar",
        { "udiskie --automount --no-tray" },
        -- "dunst",
        { "swaync" },
        { "wl-paste --type text --watch cliphist store" },
        { "wl-paste --type image --watch cliphist store" },
        { script_path .. "awwwallpaper" },
        { script_path .. "batterynotify" },
        -- "dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE",
        { "hyprpm reload -n" },
        { "librewolf",                                   { workspace = 2 } },
        { "ghostty",                                     { workspace = 1 } },
}
hl.on("hyprland.start", function()
        -- for _, cmd in ipairs(cmds) do
        --         hl.exec_cmd(cmd[1], cmd[2] )
        -- end,
        hl.exec_cmd(script_path .. "polkitkdeauth")
        hl.exec_cmd("udiskie --automount --no-tray")
        hl.exec_cmd("swaync")
        hl.exec_cmd("wl-paste --type text --watch cliphist store")
        hl.exec_cmd("wl-paste --type image --watch cliphist store")
        hl.exec_cmd(script_path .. "awwwallpaper")
        hl.exec_cmd(script_path .. "batterynotify")
        hl.exec_cmd("hyprpm reload -n")

        hl.exec_cmd("ghostty",   { workspace = 1 })
        hl.exec_cmd("librewolf", { workspace = 2 })
end)
