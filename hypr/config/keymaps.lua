local main_mod    = "SUPER"
local script_path = "~/.local/share/bin/"
local lua_script  = "lua " .. script_path .. "lua/"
local shader      = require("functions.shader")
local volume      = require("functions.volume")

local bind = hl.bind
local exec = hl.dsp.exec_cmd

local terminal = "ghostty"
local browser  = "librewolf"

local p    = "playerctl "
local vc   = lua_script .. "volumecontrol.lua "
local bc   = lua_script .. "brightnesscontrol.lua "
local ss   = lua_script .. "screenshot.lua "
local rofi = "pkill -x rofi || "
local dsp  = hl.dsp
local ws   = dsp.workspace
local win  = dsp.window

--------------------------------------------------------------------------------------------------------------------------------------------

bind("ALT + F4", exec(script_path .. "dontkillsteam"), { locked = true, repeating = true })

bind(main_mod .. " + left",  exec(script_path .. "awwwallpaper -p"))
bind(main_mod .. " + right", exec(script_path .. "awwwallpaper -n"))

---- PLAYER --------------------------------------------------------------------------------------------------------------------------------

bind("Prior",         exec(p .. "position 10-"), { locked = true, repeating = true })
bind("Next",          exec(p .. "position 10+"), { locked = true, repeating = true })
bind("Home",          exec(p .. "play-pause"),   { locked = true })
bind("End",           exec(p .. "play-pause"),   { locked = true })
bind("SHIFT + Prior", exec(p .. "previous"),     { locked = true })
bind("SHIFT + Next",  exec(p .. "next"),         { locked = true })

---- MEDIA ---------------------------------------------------------------------------------------------------------------------------------

-- bind("F1",        exec(lua_script .. "shader.lua toggle"), { locked = true })
bind("F1", function() shader.toggle("dark.frag") end, { locked = true })
bind("F2", exec(vc .. "set Master - 5"),              { locked = true, repeating = true })
bind("F3", exec(vc .. "set Master + 5"),              { locked = true, repeating = true })
-- bind("F2",        function() volume.set() end,              { locked = true, repeating = true })
-- bind("F3",        function() volume.set() end,              { locked = true, repeating = true })
bind("F4",        exec(vc .. "set Capture toggle"),     { locked = true })
bind("F6",        exec(bc .. "set 5 +"),                { locked = true, repeating = true })
bind("F5",        exec(bc .. "set 5 -"),                { locked = true, repeating = true })
bind("F7",        exec(ss .. "s"),                      { locked = true })
bind("ALT + F7",  exec(ss .. "a"),                      { locked = true })
bind("F8",        exec(script_path .. "screenshot tx"), { locked = true })
bind("F11",       exec(script_path .. "recorder s"),    { locked = true })
bind("ALT + F11", exec(script_path .. "recorder sa"),   { locked = true })

-- # bind   =     ,F12 ,exec ,$scrPath/recorder m
-- # bind   = ALT ,F12 ,exec ,$scrPath/recorder ma

bind("Print", exec(script_path .. "screenshot m"))

-- bindm = $mainMod ,mouse:272 ,movewindow
-- bindm = $mainMod ,mouse:273 ,resizewindow

---- APPS ----------------------------------------------------------------------------------------------------------------------------------

bind(main_mod .. " + B",      exec(browser))
bind(main_mod .. " + Return", exec(terminal))

---- SCRIPTS -------------------------------------------------------------------------------------------------------------------------------

bind(main_mod .. " + P",                    exec(lua_script .. "hyprpicker.lua"))
bind(main_mod .. " + I",                    exec(rofi .. script_path .. "cpu m"))
bind(main_mod .. " + O",                    exec(rofi .. script_path .. "gpu m"))
bind(main_mod .. " + S",                    exec(rofi .. script_path .. "shaders list"))
bind(main_mod .. " + Y",                    exec(rofi .. script_path .. "cliphist c"))
bind("SHIFT + Space",                       exec(rofi .. script_path .. "rofilaunch"))
bind(main_mod .. " + W",                    exec(rofi .. script_path .. "awwwallselect"))
bind(main_mod .. " + SHIFT + W",            exec(rofi .. script_path .. "wifimenu -o i"))
bind(main_mod .. " + SHIFT + T",            exec(rofi .. script_path .. "themeselect"))
bind(main_mod .. " + T",                    exec("swaync-client -t"))
bind(main_mod .. " + SHIFT + bracketright", exec(lua_script .. "waybar.lua set right"))
bind(main_mod .. " + SHIFT + bracketleft",  exec(lua_script .. "waybar.lua set bottom"))

-- bind = $mainMod SHIFT ,W     ,exec ,pkill -x qs || qs -p $confDir/quickshell/modules/Wallpicker.qml

bind(main_mod .. " + Space", ws.toggle_special("special"))
bind(main_mod .. " + 0",     win.move({ workspace = "special" }))
bind(main_mod .. " + 9",     win.move({ workspace = "+0" }))

bind(main_mod .. " + Escape",         win.close(),                           { locked = true, repeating = true })
bind(main_mod .. " + ALT + N",        exec(script_path .. "windowpin"))
bind(main_mod .. " + N",              win.float({ action = "toggle" }))
bind(main_mod .. " + M",              win.fullscreen({ action = "toggle" }))
bind("CTRL + Return",                 exec("hyprlock"))
bind(main_mod .. " + semicolon",      exec(script_path .. "kbswitch"))
bind(main_mod .. " + SHIFT + Escape", hl.dsp.exit())

bind(main_mod .. " + semicolon", exec(lua_script .. "kbswitch.lua"))

---- WINDOWS -------------------------------------------------------------------------------------------------------------------------------

bind(main_mod .. " + H", dsp.focus({ workspace = "-1" }), { locked = true, repeating = true })
bind(main_mod .. " + L", dsp.focus({ workspace = "+1" }), { locked = true, repeating = true })
bind(main_mod .. " + A", dsp.focus({ workspace = "-1" }), { locked = true, repeating = true })
bind(main_mod .. " + F", dsp.focus({ workspace = "+1" }), { locked = true, repeating = true })

bind(main_mod .. " + bracketleft",         win.move({ workspace = "-1", follow = false }))
bind(main_mod .. " + bracketright",        win.move({ workspace = "+1", follow = false }))
bind(main_mod .. " + CTRL + bracketleft",  win.move({ workspace = "-1", follow = true }))
bind(main_mod .. " + CTRL + bracketright", win.move({ workspace = "+1", follow = true }))

---- GROUPS --------------------------------------------------------------------------------------------------------------------------------

bind(main_mod .. " + G",        dsp.group.toggle())
bind(main_mod .. " + CTRL + H", dsp.group.prev())
bind(main_mod .. " + CTRL + L", dsp.group.next())

-- bind ( main_mod ..     "G" ,hy3:changegroup ,toggletab)
