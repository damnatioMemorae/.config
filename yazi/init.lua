Status:children_add(function()
        local h = cx.active.current.hovered
        if h == nil or ya.target_family() ~= "unix" then
                return ui.Line({})
        end

        return ui.Line({
                ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
                ui.Span(":"),
                ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
                ui.Span(" "),
        })
end, 500, Status.RIGHT)

if os.getenv("NVIM") then
        require("toggle-pane"):entry("min-preview")
end

require("full-border"):setup({
        type = ui.Border.PLAIN,
})

th.git                = th.git or {}
th.git.untracked_sign = "▌"
th.git.modified_sign  = "▌"
th.git.added_sign     = "▌"
th.git.deleted_sign   = "🭶"
th.git.untracked      = ui.Style():fg("#7c7157")
th.git.modified       = ui.Style():fg("#f9e2af")
th.git.added          = ui.Style():fg("#7c7157")
th.git.deleted        = ui.Style():fg("#f38ba8")

function Entity:click(event, up)
        if up then
                return
        end

        ya.emit("reveal", { self._file.url })
        if event.is_middle then
                ya.emit("open", { interactive = true })
        elseif event.is_right then
                ya.emit("plugin", { "smart-enter" })
        end
end

Status:children_add(function(self)
        local h = self._current.hovered
        if h and h.link_to then
                return " -> " .. tostring(h.link_to)
        else
                return ""
        end
end, 3300, Status.LEFT)

require("git"):setup()

require("telegram-send"):setup({
        command      = "telegram-send --file",
        notification = true,
})

require("toggle-pane"):entry("min-parent")

require("simple-tag"):setup({
        ui_mode        = "icon",
        hints_disabled = false,
        linemode_order = 500,
        save_path      = os.getenv("HOME") .. "/.config/yazi/tags",
        colors         = {
                reversed = true,
                ["*"] = "#cba6f7",
                ["$"] = "#a6e3a1",
                ["!"] = "#fab387",
                ["1"] = "#74c7ec",
                ["p"] = "#f38ba8",
        },
        icons          = {
                -- default  = "󰚋",
                -- ["*"] = "*",
                -- ["$"] = "",
                -- ["!"] = "",
                -- ["p"] = "",
                default  = "🬀",
                ["*"] = "🬀",
                ["$"] = "🬀",
                ["!"] = "🬀",
                ["p"] = "🬀",
        },

})
