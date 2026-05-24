local bind   = require("core.utils").bind
local shader = require("functions.shader")
local cross  = require("functions.cross")

local terminal = "ghostty"
local browser  = "librewolf"

local path = "~/.local/share/bin"
local rofi = "pkill -x rofi || "
local dsp  = hl.dsp

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
        -- { "F2",      function() volume.get("Master") end,                               { locked = true, repeating = true } },
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
        -- { "<D-left>",           script("awwwallpaper -p") },
        -- { "<D-right>",          script("awwwallpaper -n") },
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
local navigation = {
        { "<A-F4>",             script("dontkillsteam"),                              { locked = true, repeating = true }, "Close window" },

        { "<D-Space>",          dsp.workspace.toggle_special("magic") },
        { "<D-0>",              dsp.window.move({ workspace = "special:magic" }) },
        { "<D-9>",              dsp.window.move({ workspace = "+0" }) },

        { "<D-x>",              dsp.workspace.toggle_special("minimize") },
        { "<D-x>",              dsp.window.move({ workspace = "+0" }) },
        { "<D-x>",              dsp.workspace.toggle_special("minimize") },
        { "<D-x>",              dsp.window.move({ workspace = "special:minimize" }) },
        { "<D-x>",              dsp.workspace.toggle_special("minimize") },

        { "<D-Escape>",         dsp.window.close(),                                   { locked = true, repeating = true } },
        { "<D-A-n>",            script("windowpin") },
        { "<D-n>",              dsp.window.float({ action = "toggle" }) },
        { "<D-m>",              dsp.window.fullscreen({ action = "toggle" }) },
        { "<C-Return>",         run("hyprlock") },
        { "<D-semicolon>",      run(path .. "/" .. "kbswitch") },
        { "<D-S-Escape>",       hl.dsp.exit() },

        { "<D-semicolon>",      script("kbswitch.lua") },

        -- { "<D-h>",              dsp.focus({ workspace = "-1" }),                      { locked = true, repeating = true } },
        -- { "<D-l>",              dsp.focus({ workspace = "+1" }),                      { locked = true, repeating = true } },
        -- { "<D-a>",              dsp.focus({ workspace = "-1" }),                      { locked = true, repeating = true } },
        -- { "<D-f>",              dsp.focus({ workspace = "+1" }),                      { locked = true, repeating = true } },

        { "<D-left>",           function() cross.moveWin("l", false) end,             { locked = true, repeating = true } },
        { "<D-down>",           function() cross.moveWin("d", false) end,             { locked = true, repeating = true } },
        { "<D-up>",             function() cross.moveWin("u", false) end,             { locked = true, repeating = true } },
        { "<D-right>",          function() cross.moveWin("r", false) end,             { locked = true, repeating = true } },

        { "<D-h>",              function() cross.focus("l") end,                      { locked = true, repeating = true } },
        { "<D-j>",              function() cross.focus("d") end,                      { locked = true, repeating = true } },
        { "<D-k>",              function() cross.focus("u") end,                      { locked = true, repeating = true } },
        { "<D-l>",              function() cross.focus("r") end,                      { locked = true, repeating = true } },

        { "<D-S-Space>",        function() cross.focus("t") end,                      { locked = true, repeating = true } },

        { "<D-1>",              dsp.focus({ workspace = 1 }),                         { locked = true, repeating = true } },
        { "<D-2>",              dsp.focus({ workspace = 2 }),                         { locked = true, repeating = true } },
        { "<D-3>",              dsp.focus({ workspace = 3 }),                         { locked = true, repeating = true } },
        { "<D-4>",              dsp.focus({ workspace = 4 }),                         { locked = true, repeating = true } },
        { "<D-5>",              dsp.focus({ workspace = 5 }),                         { locked = true, repeating = true } },
        { "<D-6>",              dsp.focus({ workspace = 6 }),                         { locked = true, repeating = true } },
        { "<D-7>",              dsp.focus({ workspace = 7 }),                         { locked = true, repeating = true } },
        { "<D-8>",              dsp.focus({ workspace = 8 }),                         { locked = true, repeating = true } },
        { "<D-9>",              dsp.focus({ workspace = 9 }),                         { locked = true, repeating = true } },

        { "<D-A-1>",            dsp.window.move({ workspace = 1 }),                   { locked = true, repeating = true } },
        { "<D-A-2>",            dsp.window.move({ workspace = 2 }),                   { locked = true, repeating = true } },
        { "<D-A-3>",            dsp.window.move({ workspace = 3 }),                   { locked = true, repeating = true } },
        { "<D-A-4>",            dsp.window.move({ workspace = 4 }),                   { locked = true, repeating = true } },
        { "<D-A-5>",            dsp.window.move({ workspace = 5 }),                   { locked = true, repeating = true } },
        { "<D-A-6>",            dsp.window.move({ workspace = 6 }),                   { locked = true, repeating = true } },
        { "<D-A-7>",            dsp.window.move({ workspace = 7 }),                   { locked = true, repeating = true } },
        { "<D-A-8>",            dsp.window.move({ workspace = 8 }),                   { locked = true, repeating = true } },
        { "<D-A-9>",            dsp.window.move({ workspace = 9 }),                   { locked = true, repeating = true } },

        { "<D-S-h>",            dsp.focus({ direction = "left" }) },
        { "<D-S-j>",            dsp.focus({ direction = "down" }) },
        { "<D-S-k>",            dsp.focus({ direction = "up" }) },
        { "<D-S-l>",            dsp.focus({ direction = "right" }) },

        { "<D-bracketleft>",    dsp.window.move({ workspace = "-1", follow = true }) },
        { "<D-bracketright>",   dsp.window.move({ workspace = "+1", follow = true }) },
        { "<D-C-bracketleft>",  dsp.window.move({ workspace = "-1", follow = false }) },
        { "<D-C-bracketright>", dsp.window.move({ workspace = "+1", follow = false }) },

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
        navigation,
        grouping,
}

for _, group in ipairs(binds) do
        for _, spec in ipairs(group) do
                bind(spec)
        end
end
