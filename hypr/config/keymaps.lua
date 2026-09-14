local hy3    = hl.plugin.hy3
local utils  = require "core.utils"
local bind   = utils.bind
local shader = require "functions.shader"
-- local cross  = require("functions.cross")

local terminal = "ghostty"
-- local terminal = "kitty"
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

---- PLAYER --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

bind { "Prior", run "playerctl position 10-", { locked = true, repeating = true } }
bind { "Next", run "playerctl position 10+", { locked = true, repeating = true } }
bind { "Home", run "playerctl play-pause", { locked = true } }
bind { "End", run "playerctl play-pause", { locked = true } }
bind { "<S-Prior>", run "playerctl previous", { locked = true } }
bind { "<S-Next>", run "playerctl next", { locked = true } }

---- MEDIA ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

bind { "F1", function() shader.toggle "dark.frag" end, { locked = true } }
bind { "F2", script("lua/volumecontrol.lua set Master - 5", "lua"), { locked = true, repeating = true } }
-- bind { "F2", function() volume.get "Master" end, { locked = true, repeating = true } }
bind { "F3", script("lua/volumecontrol.lua set Master + 5", "lua"), { locked = true, repeating = true } }
bind { "F4", script("lua/volumecontrol.lua set Capture toggle", "lua"), { locked = true } }
bind { "F6", script("lua/brightnesscontrol.lua set 5 +", "lua"), { locked = true, repeating = true } }
bind { "F5", script("lua/brightnesscontrol.lua set 5 -", "lua"), { locked = true, repeating = true } }
bind { "F7", script("lua/screenshot.lua s flameshot", "lua"), { locked = true } }
bind { "<A-F7>", script("lua/screenshot.lua a", "lua"), { locked = true } }
bind { "F8", script "lua/screenshot tx", { locked = true } }
bind { "F11", script "recorder s", { locked = true } }
bind { "<A-F11>", script "recorder sa", { locked = true } }
bind { "Print", script "screenshot m" }

---- APPS ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

bind { "<D-b>", run(browser) }
bind { "<D-Return>", run(terminal) }

---- SCRIPTS -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

bind { "<D-S-bracketright>", script("lua/waybar.lua set right", "lua") }
bind { "<D-S-bracketleft>", script("lua/waybar.lua set bottom", "lua") }

bind { "<D-semicolon>", script "kbswitch.lua" }
bind { "<D-p>", script("lua/hyprpicker.lua", "lua") }
bind { "<D-o>", run(rofi .. path .. "/" .. "gpu m") }
bind { "<D-i>", run(rofi .. path .. "/" .. "cpu m") }
bind { "<D-s>", run(rofi .. path .. "/" .. "shaders list") }
bind { "<D-y>", run(rofi .. path .. "/" .. "cliphist c") }
bind { "<S-Space>", run(rofi .. path .. "/" .. "rofilaunch") }
bind { "<D-w>", run(rofi .. path .. "/" .. "awwwallselect") }
bind { "<D-S-w>", run(rofi .. path .. "/" .. "wifimenu -o i") }
bind { "<D-S-t>", run(rofi .. path .. "/" .. "themeselect") }
bind { "<D-t>", run "swaync-client -t" }

---- SPECIAL WS ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

bind { "<D-Space>", dsp.workspace.toggle_special "magic" }
bind { "<D-0>", dsp.window.move { workspace = "special:magic" } }
bind { "<D-9>", dsp.window.move { workspace = "+0" } }

bind { "<D-x>", dsp.workspace.toggle_special "minimize" }
bind { "<D-x>", dsp.window.move { workspace = "+0" } }
bind { "<D-x>", dsp.workspace.toggle_special "minimize" }
bind { "<D-x>", dsp.window.move { workspace = "special:minimize" } }
bind { "<D-x>", dsp.workspace.toggle_special "minimize" }

---- RESIZE WINDOW -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

bind { "<D-A-h>", dsp.window.resize { x = -10, y = 0, relative = true }, { locked = true, repeating = true } }
bind { "<D-A-j>", dsp.window.resize { x = 0, y = -10, relative = true }, { locked = true, repeating = true } }
bind { "<D-A-k>", dsp.window.resize { x = 0, y = 10, relative = true }, { locked = true, repeating = true } }
bind { "<D-A-l>", dsp.window.resize { x = 10, y = 0, relative = true }, { locked = true, repeating = true } }

---- MOVE FOCUS ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

bind { "<D-S-h>", dsp.focus { direction = "left" } }
bind { "<D-S-j>", dsp.focus { direction = "down" } }
bind { "<D-S-k>", dsp.focus { direction = "up" } }
bind { "<D-S-l>", dsp.focus { direction = "right" } }

---- MOVE FOCUS TO WS ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

bind { "<D-h>", dsp.focus { workspace = "-1" }, { locked = true, repeating = true } }
bind { "<D-l>", dsp.focus { workspace = "+1" }, { locked = true, repeating = true } }

bind { "<D-1>", dsp.focus { workspace = 1 }, { locked = true, repeating = true } }
bind { "<D-2>", dsp.focus { workspace = 2 }, { locked = true, repeating = true } }
bind { "<D-3>", dsp.focus { workspace = 3 }, { locked = true, repeating = true } }
bind { "<D-4>", dsp.focus { workspace = 4 }, { locked = true, repeating = true } }
bind { "<D-5>", dsp.focus { workspace = 5 }, { locked = true, repeating = true } }
bind { "<D-6>", dsp.focus { workspace = 6 }, { locked = true, repeating = true } }
bind { "<D-7>", dsp.focus { workspace = 7 }, { locked = true, repeating = true } }
bind { "<D-8>", dsp.focus { workspace = 8 }, { locked = true, repeating = true } }
bind { "<D-9>", dsp.focus { workspace = 9 }, { locked = true, repeating = true } }

---- MOVE WINDOW ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- bind { "<D-left>", dsp.window.move { workspace = "-1" }, { locked = true, repeating = true } }
-- bind { "<D-right>", dsp.window.move { workspace = "+1" }, { locked = true, repeating = true } }
-- bind { "<D-C-left>", dsp.window.move { workspace = "-1", follow = false } }
-- bind { "<D-C-right>", dsp.window.move { workspace = "+1", follow = false } }

-- bind { "<D-C-h>", function()
--         if hy3 then return hl.dispatch(hy3.move_window "left") end
--         return hl.dispatch(dsp.window.move { direction = "left" })
-- end, { locked = true, repeating = true } }
-- bind { "<D-C-j>", function()
--         if hy3 then return hl.dispatch(hy3.move_window "down") end
--         return hl.dispatch(dsp.window.move { direction = "down" })
-- end, { locked = true, repeating = true } }
-- bind { "<D-C-k>", function()
--         if hy3 then return hl.dispatch(hy3.move_window "up") end
--         return hl.dispatch(dsp.window.move { direction = "up" })
-- end, { locked = true, repeating = true } }
-- bind { "<D-C-l>", function()
--         if hy3 then return hl.dispatch(hy3.move_window "right") end
--         return hl.dispatch(dsp.window.move { direction = "right" })
-- end, { locked = true, repeating = true } }

---- MOVE WINDOW TO WS ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

bind { "<D-A-1>", dsp.window.move { workspace = 1 }, { locked = true, repeating = true } }
bind { "<D-A-2>", dsp.window.move { workspace = 2 }, { locked = true, repeating = true } }
bind { "<D-A-3>", dsp.window.move { workspace = 3 }, { locked = true, repeating = true } }
bind { "<D-A-4>", dsp.window.move { workspace = 4 }, { locked = true, repeating = true } }
bind { "<D-A-5>", dsp.window.move { workspace = 5 }, { locked = true, repeating = true } }
bind { "<D-A-6>", dsp.window.move { workspace = 6 }, { locked = true, repeating = true } }
bind { "<D-A-7>", dsp.window.move { workspace = 7 }, { locked = true, repeating = true } }
bind { "<D-A-8>", dsp.window.move { workspace = 8 }, { locked = true, repeating = true } }
bind { "<D-A-9>", dsp.window.move { workspace = 9 }, { locked = true, repeating = true } }

---- GROUPS --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- bind { "<D-j>", function()
--         if hy3 then return hl.dispatch(hy3.make_group "v") end
-- end }
-- bind { "<D-k>", function()
--         if hy3 then return hl.dispatch(hy3.make_group "h") end
-- end }
-- bind { "<D-g>", function()
--         if hy3 then return hl.dispatch(hy3.change_group "toggletab") end
--         return hl.dispatch(dsp.group.toggle())
-- end }
-- bind { "<D-left>", function()
--         if hy3 then return hl.dispatch(hy3.focus_tab { direction = "left", wrap = true }) end
--         return hl.dispatch(dsp.group.prev())
-- end, { locked = true, repeating = true } }
-- bind { "<D-right>", function()
--         if hy3 then return hl.dispatch(hy3.focus_tab { direction = "right", wrap = true }) end
--         return hl.dispatch(dsp.group.next())
-- end, { locked = true, repeating = true } }

---- MISC ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- bind { "<D-comma>", function()
--         if hy3 then return hl.dispatch(hy3.toggle_focus_layer()) end
-- end }
-- bind { "<D-Escape>", function()
--         if hy3 then return hl.dispatch(hy3.kill_active()) end
--         return hl.dispatch(dsp.window.close())
-- end }
-- bind { "<D-Escape>", hy3.kill_active() }
bind { "<D-Escape>", dsp.window.close() }
bind { "<D-F4>", dsp.window.close(), { locked = true, repeating = true } }
bind { "<D-A-n>", script "windowpin" }
bind { "<D-n>", dsp.window.float { action = "toggle" } }
bind { "<D-m>", dsp.window.fullscreen { action = "toggle" } }
bind { "<C-Return>", run "hyprlock" }
bind { "<D-semicolon>", run(path .. "/" .. "kbswitch") }
bind { "<D-S-Escape>", hl.dsp.exit() }
