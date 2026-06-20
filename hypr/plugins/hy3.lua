local hy3 = hl.plugin.hy3
hy3.make_group("h" | "v" | "tab" | "opposite", {
        toggle    = true | false,
        ephemeral = true | false | "force",
})

hy3.change_group("h" | "v" | "tab" | "untab" | "toggletab" | "opposite")

hy3.set_ephemeral(true | false | "true" | "false")

hy3.move_focus("l" | "r" | "u" | "d" | "left" | "right" | "up" | "down", {
        visible = true | false,
        warp    = true | false,
})

hy3.toggle_focus_layer({
        warp = true | false,
})

hy3.warp_cursor()

hy3.move_window("l" | "r" | "u" | "d" | "left" | "right" | "up" | "down", {
        once    = true | false,
        visible = true | false,
})

hy3.move_to_workspace("<workspace>", {
        follow = true | false,
        warp   = true | false,
})

hy3.change_focus("top" | "bottom" | "raise" | "lower" | "tab" | "tabnode")


hy3.focus_tab({
        direction = "l" | "r" | "left" | "right",
        mouse     = "ignore" | "prioritize_hovered" | "require_hovered",
        wrap      = true | false,
})

hy3.focus_tab({

        mouse = "ignore" | "prioritize_hovered" | "require_hovered",
        wrap  = true | false,
})

hy3.set_swallow(true | false | "true" | "false" | "toggle")

hy3.kill_active()

hy3.expand("expand" | "shrink" | "base" | "maximize" | "fullscreen", {
        fullscreen = "" | "intermediate_maximize" | "fullscreen_maximize" | "maximize_only",
})

hy3.lock_tab(nil | "" | "toggle" | "lock" | "unlock")

hy3.equalize({
        scope     = "" | "group" | "workspace",
        workspace = true | false,
        recursive = true | false,
})

hy3.debug_nodes()
