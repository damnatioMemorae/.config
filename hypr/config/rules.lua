local window_rules = {
        { float = true,     match = { class = "^(firefox)$", title = "^(Picture-in-Picture)$" } },
        { float = true,     match = { class = "^(firefox)$", title = "^(Library)$" } },
        { float = true,     match = { class = "^(librewolf)$", title = "^(Picture-in-Picture)$" } },
        { float = true,     match = { class = "^(librewolf)$", title = "^(Library)$" } },
        { float = true,     match = { class = "vlc" } },
        { float = true,     match = { class = "kvantummanager" } },
        { float = true,     match = { class = "qt5ct" } },
        { float = true,     match = { class = "qt6ct" } },
        { float = true,     match = { class = "nwg-look" } },
        { float = true,     match = { class = "org.kde.ark" } },
        { float = true,     match = { class = "pavucontrol" } },
        { float = true,     match = { class = "blueman-manager" } },
        { float = true,     match = { class = "nm-applet" } },
        { float = true,     match = { class = "nm-connection-editor" } },
        { float = true,     match = { class = "org.kde.polkit-kde-authentication-agent-1" } },
        { float = true,     match = { class = "wev" } },
        { float = true,     match = { title = "(Select|Open)( a)? (File|Folder)(s)?" } },
        { float = true,     match = { title = "File (Operation|Upload)( Progress)?" } },
        { float = true,     match = { title = "File (Operation|Upload)( Progress)?" } },
        { float = true,     match = { title = ".* Properties" } },
        { float = true,     match = { title = "Export Image as PNG" } },
        { float = true,     match = { title = "GIMP Crash Debug" } },
        { float = true,     match = { title = "Save As" } },
        { float = true,     match = { title = "Library" } },
        { float = true,     match = { class = "Signal" } },
        { float = true,     match = { class = "com.github.rafostar.Clapper" } },
        { float = true,     match = { class = "app.drey.Warp" } },
        { float = true,     match = { class = "net.davidotek.pupgui2" } },
        { float = true,     match = { class = "yad" } },
        { float = true,     match = { class = "eog" } },
        { float = true,     match = { class = "io.github.alainm23.planify" } },
        { float = true,     match = { class = "io.gitlab.theevilskeleton.Upscaler" } },
        { float = true,     match = { class = "com.github.unrud.VideoDownloader" } },
        { float = true,     match = { class = "io.gitlab.adhami3310.Impression" } },
        { float = true,     match = { "class com.yazi.open" } },
        { size = "960 540", match = { "class com.yazi.open" } },
}
for _, rule in ipairs(window_rules) do
        return hl.window_rule(rule)
end

-- group deny, no_blur on, match:float 1
-- no_dim on, opacity 0.5 override 0.5 override 0.5 override, match:class com.q.bg
-- no_blur on, match:float false
-- group deny, float on, size 540 380, move (window_w) (window_h*0.9), pin on, match:title Картинка в картинке
-- group deny, float on, size 960 540, move (window_w) (window_h*0.9), pin on, match:title Picture-in-Picture
-- group deny, float on, size 720 380, pin on, match:class hyprland-share-picker
-- group deny, float on, size 650 340, move ((monitor_w*0.35)) (44), pin on, match:class org.pulseaudio.pavucontrol
-- group deny, float on, size 460 270, pin on, match:title Discord Popout
-- render_unfocused on, match:class kitty-bg

local layer_rules = {
        { match = { namespace = "rofi" },                       dim_around = true },
        { match = { namespace = "notifications" },              no_screen_share = true },
        { match = { namespace = "swaync-notification-window" }, no_screen_share = true },
        { match = { namespace = "swaync-control-center" },      no_screen_share = true },
        { match = { namespace = "swaync-control-center" },      dim_around = true },
        { match = { namespace = "selection" },                  no_anim = true },
        { match = { namespace = "hyprpicker" },                 animation = "fade in" },
}
for _, rule in ipairs(layer_rules) do
        return hl.layer_rule(rule)
end
