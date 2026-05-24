local M = {}
--------------------------------------------------------------------------------------------------------------------------------------------

---TOGGLE SHADER
---@param shader string
function M.toggle(shader)
        local current_shader = hl.get_config("decoration.screen_shader")
        shader               = "~/.config/hypr/shaders/" .. shader

        if current_shader == "" then
                hl.config({ decoration = { screen_shader = shader } })
                hl.notification.create({ text = shader, timeout = 2000, color = "rgb(89dceb)", font_size = 12 })
        else
                hl.config({ decoration = { screen_shader = "" } })
                hl.notification.create({ text = shader, timeout = 2000, color = "rgb(89dceb)", font_size = 12 })
        end
end

--------------------------------------------------------------------------------------------------------------------------------------------
return M
