local M = {}
--------------------------------------------------------------------------------------------------------------------------------------------

function M.aboba()
        local current = tostring(hl.get_active_workspace()):match("%((%d+):")
        hl.notification.create({ text = current, timeout = 2000, color = "rgb(89dceb)", font_size = 12 })
end

function M.moveWin(direction, follow)
        local current = tostring(hl.get_active_workspace()):match("%((%d+):")

        if direction == "l" then
                if current == "5" then
                        hl.dispatch(hl.dsp.window.move({ workspace = 1, folow = follow }))
                elseif current == "7" then
                        hl.dispatch(hl.dsp.window.move({ workspace = 5, follow = follow }))
                end
        elseif direction == "r" then
                if current == "5" then
                        hl.dispatch(hl.dsp.window.move({ workspace = 7, follow = follow }))
                elseif current == "1" then
                        hl.dispatch(hl.dsp.window.move({ workspace = 5, follow = follow }))
                end
        elseif direction == "u" then
                if current == "5" then
                        hl.dispatch(hl.dsp.window.move({ workspace = 3, follow = follow }))
                elseif current == "8" then
                        hl.dispatch(hl.dsp.window.move({ workspace = 5, follow = follow }))
                end
        elseif direction == "d" then
                if current == "5" then
                        hl.dispatch(hl.dsp.window.move({ workspace = 8, follow = follow }))
                elseif current == "3" then
                        hl.dispatch(hl.dsp.window.move({ workspace = 5, follow = follow }))
                end
        end
end

local l_in  = "workspacesIn"
local l_out = "workspacesOut"
local curve = "md3_standard"
local c_in  = "md3_decel"
local c_out = "md3_accel"

function M.focus(direction)
        local current = tostring(hl.get_active_workspace()):match("%((%d+):")

        if direction == "l" then
                if current == "5" then
                        hl.animation({ leaf = l_in, enabled = true, speed = 5, bezier = curve, style = "slide left" })
                        hl.animation({ leaf = l_out, enabled = true, speed = 5, bezier = curve, style = "slide left" })
                        hl.dispatch(hl.dsp.focus({ workspace = "1" }))
                elseif current == "7" then
                        hl.animation({ leaf = l_in, enabled = true, speed = 5, bezier = curve, style = "slide left" })
                        hl.animation({ leaf = l_out, enabled = true, speed = 5, bezier = curve, style = "slide left" })
                        hl.dispatch(hl.dsp.focus({ workspace = "5" }))

                elseif current == "9" then
                        hl.animation({ leaf = l_in, enabled = true, speed = 5, bezier = curve, style = "slide top" })
                        hl.animation({ leaf = l_out, enabled = true, speed = 5, bezier = curve, style = "slide bottom" })
                        hl.dispatch(hl.dsp.focus({ workspace = "6" }))
                elseif current == "6" then
                        hl.animation({ leaf = l_in, enabled = true, speed = 5, bezier = curve, style = "slide top" })
                        hl.animation({ leaf = l_out, enabled = true, speed = 5, bezier = curve, style = "slide bottom" })
                        hl.dispatch(hl.dsp.focus({ workspace = "4" }))
                elseif current == "4" then
                        hl.animation({ leaf = l_in, enabled = true, speed = 5, bezier = curve, style = "slide top" })
                        hl.animation({ leaf = l_out, enabled = true, speed = 5, bezier = curve, style = "slide bottom" })
                        hl.dispatch(hl.dsp.focus({ workspace = "2" }))
                end
        elseif direction == "r" then
                if current == "5" then
                        hl.animation({ leaf = l_in, enabled = true, speed = 5, bezier = curve, style = "slide right" })
                        hl.animation({ leaf = l_out, enabled = true, speed = 5, bezier = curve, style = "slide right" })
                        hl.dispatch(hl.dsp.focus({ workspace = "7" }))
                elseif current == "1" then
                        hl.animation({ leaf = l_in, enabled = true, speed = 5, bezier = curve, style = "slide right" })
                        hl.animation({ leaf = l_out, enabled = true, speed = 5, bezier = curve, style = "slide right" })
                        hl.dispatch(hl.dsp.focus({ workspace = "5" }))

                elseif current == "2" then
                        hl.animation({ leaf = l_in, enabled = true, speed = 5, bezier = curve, style = "slide top" })
                        hl.animation({ leaf = l_out, enabled = true, speed = 5, bezier = curve, style = "slide bottom" })
                        hl.dispatch(hl.dsp.focus({ workspace = "4" }))
                elseif current == "4" then
                        hl.animation({ leaf = l_in, enabled = true, speed = 5, bezier = curve, style = "slide top" })
                        hl.animation({ leaf = l_out, enabled = true, speed = 5, bezier = curve, style = "slide bottom" })
                        hl.dispatch(hl.dsp.focus({ workspace = "6" }))
                elseif current == "6" then
                        hl.animation({ leaf = l_in, enabled = true, speed = 5, bezier = curve, style = "slide top" })
                        hl.animation({ leaf = l_out, enabled = true, speed = 5, bezier = curve, style = "slide bottom" })
                        hl.dispatch(hl.dsp.focus({ workspace = "9" }))
                end
        elseif direction == "u" then
                if current == "5" then
                        hl.animation({ leaf = l_in, enabled = true, speed = 5, bezier = curve, style = "slide top" })
                        hl.animation({ leaf = l_out, enabled = true, speed = 5, bezier = curve, style = "slide top" })
                        hl.dispatch(hl.dsp.focus({ workspace = "3" }))
                elseif current == "8" then
                        hl.animation({ leaf = l_in, enabled = true, speed = 5, bezier = curve, style = "slide top" })
                        hl.animation({ leaf = l_out, enabled = true, speed = 5, bezier = curve, style = "slide top" })
                        hl.dispatch(hl.dsp.focus({ workspace = "5" }))
                end
        elseif direction == "d" then
                if current == "5" then
                        hl.animation({ leaf = l_in, enabled = true, speed = 5, bezier = curve, style = "slide bottom" })
                        hl.animation({ leaf = l_out, enabled = true, speed = 5, bezier = curve, style = "slide bottom" })
                        hl.dispatch(hl.dsp.focus({ workspace = "8" }))
                elseif current == "3" then
                        hl.animation({ leaf = l_in, enabled = true, speed = 5, bezier = curve, style = "slide bottom" })
                        hl.animation({ leaf = l_out, enabled = true, speed = 5, bezier = curve, style = "slide bottom" })
                        hl.dispatch(hl.dsp.focus({ workspace = "5" }))
                end
        elseif direction == "t" then
                if current == "5" then
                        hl.animation({ leaf = l_in, enabled = true, speed = 5, bezier = c_in, style = "slide top" })
                        hl.animation({ leaf = l_out, enabled = true, speed = 5, bezier = c_out, style = "slide bottom" })
                        hl.dispatch(hl.dsp.focus({ workspace = "2" }))
                elseif current ~= "5" then
                        hl.animation({ leaf = l_in, enabled = true, speed = 5, bezier = c_in, style = "slide top" })
                        hl.animation({ leaf = l_out, enabled = true, speed = 5, bezier = c_out, style = "slide bottom" })
                        hl.dispatch(hl.dsp.focus({ workspace = "5" }))
                end
        end
end

--------------------------------------------------------------------------------------------------------------------------------------------
return M
