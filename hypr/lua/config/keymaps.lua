local bind   = require("lua.core.utils").bind
local shader = require("lua.functions.shader")

local terminal = "ghostty"
local browser  = "librewolf"

local path = "~/.local/share/bin"
local rofi = "pkill -x rofi || "
local dsp  = hl.dsp
local ws   = dsp.workspace
local win  = dsp.window

local function run(cmd, rules)
        return hl.dsp.exec_cmd(cmd, rules)
end

local function script(scr, ex)
        ex = ex or ""
        return hl.dsp.exec_cmd(ex .. " " .. path .. "/" .. scr)
end

local player     = {
        { "Prior",     run("playerctl position 10-"), { locked = true, repeating = true } },
        { "Next",      run("playerctl position 10+"), { locked = true, repeating = true } },
        { "Home",      run("playerctl play-pause"),   { locked = true } },
        { "End",       run("playerctl play-pause"),   { locked = true } },
        { "<S-Prior>", run("playerctl previous"),     { locked = true } },
        { "<S-Next>",  run("playerctl next"),         { locked = true } },
}
local multimedia = {
        { "F1",      function() shader.toggle("dark.frag") end,                 { locked = true } },
        { "F2",      script("lua/volumecontrol.lua set Master - 5", "lua"),     { locked = true, repeating = true } },
        { "F3",      script("lua/volumecontrol.lua set Master + 5", "lua"),     { locked = true, repeating = true } },
        { "F4",      script("lua/volumecontrol.lua set Capture toggle", "lua"), { locked = true } },
        { "F6",      script("lua/brightnesscontrol.lua set 5 +", "lua"),        { locked = true, repeating = true } },
        { "F5",      script("lua/brightnesscontrol.lua set 5 -", "lua"),        { locked = true, repeating = true } },
        { "F7",      script("lua/screenshot.lua s", "lua"),                     { locked = true } },
        { "<A-F7>",  script("lua/screenshot.lua a", "lua"),                     { locked = true } },
        { "F8",      script("lua/screenshot tx"),                               { locked = true } },
        { "F11",     script("recorder s"),                                      { locked = true } },
        { "<A-F11>", script("recorder sa"),                                     { locked = true } },

        -- # bind   =     ,F12 ,exec ,$scrPath/recorder m
        -- # bind   = ALT ,F12 ,exec ,$scrPath/recorder ma

        { "Print",   script("screenshot m") },

        -- bindm = $mainMod ,mouse:272 ,movewindow
        -- bindm = $mainMod ,mouse:273 ,resizewindow
}
local apps       = {
        { "<D-b>",      run(browser) },
        { "<D-Return>", run(terminal) },
}
local scripts    = {
        { "<D-left>",           script("awwwallpaper -p") },
        { "<D-right>",          script("awwwallpaper -n") },
        { "<D-S-bracketright>", script("lua/waybar.lua set right", "lua") },
        { "<D-S-bracketleft>",  script("lua/waybar.lua set bottom", "lua") },

        { "<D-p>",              script("lua/hyprpicker.lua", "lua") },
        { "<D-o>",              run(rofi .. path .. "/" .. "gpu m") },
        { "<D-i>",              run(rofi .. path .. "/" .. "cpu m") },
        { "<D-s>",              run(rofi .. path .. "/" .. "shaders list") },
        { "<D-y>",              run(rofi .. path .. "/" .. "cliphist c") },
        { "<S-Space>",          run(rofi .. path .. "/" .. "rofilaunch") },
        { "<D-w>",              run(rofi .. path .. "/" .. "awwwallselect") },
        { "<D-S-w>",            run(rofi .. path .. "/" .. "wifimenu -o i") },
        { "<D-S-t>",            run(rofi .. path .. "/" .. "themeselect") },
        { "<D-t>",              run("swaync-client -t") },

        -- bind = $mainMod SHIFT ,W     ,exec ,pkill -x qs || qs -p $confDir/quickshell/modules/Wallpicker.qml
}
local windows    = {
        { "<A-F4>",             script("dontkillsteam"),                       { locked = true, repeating = true }, "Close window" },

        { "<D-Space>",          ws.toggle_special("special") },
        { "<D-0>",              win.move({ workspace = "special" }) },
        { "<D-9>",              win.move({ workspace = "+0" }) },

        { "<D-Escape>",         win.close(),                                   { locked = true, repeating = true } },
        { "<D-A-n>",            script("windowpin") },
        { "<D-n>",              win.float({ action = "toggle" }) },
        { "<D-m>",              win.fullscreen({ action = "toggle" }) },
        { "<C-Return>",         run("hyprlock") },
        { "<D-semicolon>",      run(path .. "/" .. "kbswitch") },
        { "<D-S-Escape>",       hl.dsp.exit() },

        { "<D-semicolon>",      script("kbswitch.lua") },

        { "<D-h>",              dsp.focus({ workspace = "-1" }),               { locked = true, repeating = true } },
        { "<D-l>",              dsp.focus({ workspace = "+1" }),               { locked = true, repeating = true } },
        { "<D-a>",              dsp.focus({ workspace = "-1" }),               { locked = true, repeating = true } },
        { "<D-f>",              dsp.focus({ workspace = "+1" }),               { locked = true, repeating = true } },

        { "<D-bracketleft>",    win.move({ workspace = "-1", follow = true }) },
        { "<D-bracketright>",   win.move({ workspace = "+1", follow = true }) },
        { "<D-C-bracketleft>",  win.move({ workspace = "-1", follow = false }) },
        { "<D-C-bracketright>", win.move({ workspace = "+1", follow = false }) },

}
local grouping   = {
        { "<D-g>",   dsp.group.toggle() },
        { "<D-C-h>", dsp.group.prev() },
        { "<D-C-l>", dsp.group.next() },
}

local binds = {
        player,
        multimedia,
        apps,
        scripts,
        windows,
        grouping,
}

for _, group in ipairs(binds) do
        for _, spec in ipairs(group) do
                bind(spec)
        end
end
