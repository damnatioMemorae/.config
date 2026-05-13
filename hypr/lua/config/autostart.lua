local HOME        = os.getenv("HOME")
local script_path = HOME .. "/.local/share/bin/"
local cmds        = {
        -- "hyprshade auto",
        -- "$scrPath/resetxdgportal",
        -- "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
        -- "dbus-update-activation-environment --systemd --all",
        -- "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
        script_path .. "polkitkdeauth",
        -- "lua $scrPath/lua/waybar.lua set bottom",
        -- "eww --config ~/.config/eww/bottom-bar/ --restart open-many bar",
        "udiskie --automount --no-tray",
        -- "dunst",
        "swaync",
        "wl-paste --type text --watch cliphist store",
        "wl-paste --type image --watch cliphist store",
        script_path .. "awwwallpaper",
        script_path .. "batterynotify",
        -- "dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE",
        "hyprpm reload -n",
}

hl.on("hyprland.start", function()
        for _, cmd in ipairs(cmds) do
                hl.exec_cmd(cmd)
        end
        hl.exec_cmd("librewolf", { workspace = 2 })
        hl.exec_cmd("ghostty",   { workspace = 1 })
end)
