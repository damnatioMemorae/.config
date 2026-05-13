local config = {}

config.general    = {
        border_size = 0,
        col         = { active_border = "rgb(a6adc8)", inactive_border = "rgb(a6adc8)" },
        gaps_in     = 5,
        gaps_out    = 10,
        snap        = { enabled = false },
        layout      = "lua:columns",
}
config.input      = {
        follow_mouse       = 1,
        force_no_accel     = true,
        kb_layout          = "us, ru",
        numlock_by_default = true,
        sensitivity        = 0,
        touchpad           = { disable_while_typing = true, drag_lock = true, natural_scroll = false },
}
config.cursor     = {
        sync_gsettings_theme     = true,
        enable_hyprcursor        = true,
        persistent_warps         = true,
        warp_on_change_workspace = true,
        no_hardware_cursors      = true,
        hide_on_key_press        = true,
        zoom_factor              = 1.0,
        zoom_rigid               = false,
        inactive_timeout         = 4.0,
}
config.group      = {
        auto_group               = true,
        drag_into_group          = 2,
        merge_groups_on_drag     = false,
        merge_groups_on_groupbar = true,
        insert_after_current     = true,
        focus_removed_window     = true,
        col                      = {
                border_active          = "rgb(cdd6f4)",
                border_inactive        = "rgb(cdd6f4)",
                border_locked_active   = "rgb(cdd6f4)",
                border_locked_inactive = "rgb(cdd6f4)",
        },
        groupbar                 = {
                rounding         = 0,
                round_only_edges = false,
                render_titles    = false,
                scrolling        = true,
                keep_upper_gap   = false,
                gaps_out         = 0,
                gaps_in          = 0,
                indicator_height = 20,
                text_color       = "rgb(cdd6f4)",
                col              = {
                        active          = "rgba(0e0e16ff)",
                        inactive        = "rgba(14141fff)",
                        locked_active   = "rgba(f38ba8ff)",
                        locked_inactive = "rgba(0e0e16ff)",
                },
        },
}
config.decoration = {
        rounding           = 0,
        -- active_opacity     = 0.88,
        inactive_opacity   = 1,
        fullscreen_opacity = 1,
        dim_inactive       = true,
        dim_strength       = 0.25,
        -- screen_shader      = "~/.config/hypr/shaders/dark.frag",
        shadow             = {
                enabled        = false,
                range          = -2,
                sharp          = true,
                color          = 0xffcba6f7,
                color_inactive = 0xff181825,
                -- offset         = 4 4,
        },
        blur               = {
                enabled           = true,
                passes            = 4,
                size              = 1,
                new_optimizations = false,
                xray              = false,
                noise             = 0.0,
                contrast          = 1.0,
                brightness        = 1,
                vibrancy          = 0,
                vibrancy_darkness = 0,
                popups            = true,
        },
}
config.misc       = {
        middle_click_paste             = true,
        allow_session_lock_restore     = true,
        animate_manual_resizes         = true,
        animate_mouse_windowdragging   = true,
        disable_hyprland_logo          = true,
        disable_splash_rendering       = true,
        enable_swallow                 = false,
        exit_window_retains_fullscreen = false,
        font_family                    = "Monocraft",
        force_default_wallpaper        = 0,
        initial_workspace_tracking     = 2,
        layers_hog_keyboard_focus      = true,
        splash_font_family             = "Monocwraft",
        swallow_regex                  = "^(kitty|ghostty|firefox|librewolf|discord|Alacritty)$",
        vrr                            = 0,
        on_focus_under_fullscreen      = false,
        close_special_on_empty         = true,
        disable_autoreload             = false,
}
config.xwayland   = {
        force_zero_scaling = true,
}
config.binds      = {
        workspace_center_on              = true,
        allow_workspace_cycles           = true,
        hide_special_on_workspace_change = true,
        movefocus_cycles_fullscreen      = true,
}
config.opengl     = {
        nvidia_anti_flicker = 1,
}
config.ecosystem  = {
        no_update_news  = true,
        no_donation_nag = true,
}
config.debug      = {
        disable_logs    = false,
        damage_tracking = 0,
        suppress_errors = false,
}

--[[
config.plugin= {
        hy3 ={
                no_gaps_when_only    = 0,
                node_collapse_policy = 0,
                tabs= {
                        height       = 22,
                        padding      = 0,
                        radius       = 0,
                        border_width = 0,
                        render_text  = true,
                        text_center  = false,
                        text_font    = Monocraft,
                        text_height  = 10,
                        text_padding = 12,

                        col.active          = rgba(0e0e16ff),
                        col.active.border   = rgba(0e0e16ff),
                        col.active.text     = rgba(0e0e16ff),

                        col.focused         = rgba(0e0e16ff),
                        col.focused.border  = rgba(0e0e16ff),
                        col.focused.text    = rgba(0e0e16ff),

                        col.inactive        = rgba(14141fff),
                        col.inactive.border = rgba(14141fff),
                        col.inactive.text   = rgba(14141fff),

                        col.urgent          = rgba(281d29ff),
                        col.urgent.border   = rgba(281d29ff),
                        col.urgent.text     = rgba(281d29ff),
                }
                autotile= {
                        enable         = false,
                        trigger_width  = 800,
                        trigger_height = 300,
                }
        }
}
--]]

hl.config(config)
