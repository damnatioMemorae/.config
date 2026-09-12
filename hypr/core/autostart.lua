local script_path = (os.getenv "HOME") .. "/.local/share/bin/"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

hl.on("hyprland.start", function()
        hl.exec_cmd(script_path .. "polkitkdeauth")
        hl.exec_cmd "udiskie --automount --no-tray"
        hl.exec_cmd "swaync"
        hl.exec_cmd "wl-paste --type text --watch cliphist store"
        hl.exec_cmd "wl-paste --type image --watch cliphist store"
        hl.exec_cmd(script_path .. "awwwallpaper")
        hl.exec_cmd(script_path .. "batterynotify")
        hl.exec_cmd "hyprpm reload -n"

        -- hl.exec_cmd("ghostty",   { workspace = 1, silent = true })
        hl.exec_cmd("kitty",   { workspace = 1, silent = true })
        hl.exec_cmd("librewolf", { workspace = 2, silent = true })
        hl.exec_cmd "discord"
end)
