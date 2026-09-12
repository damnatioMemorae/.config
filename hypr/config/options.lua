local groups = require "themes".Groups
local colors = require "themes".Colors

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local config = {} ---@class HL.ConfigOpt
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---@type HL.ConfigOpt.General
config.general    = {
        border_size = 0,
        col         = { active_border = groups.borderActive, inactive_border = groups.borderInactive },
        gaps_in     = 5,
        gaps_out    = 10,
        snap        = { enabled = false },
        -- layout      = "lua:columns",
        layout      = hl.plugin.hy3 and "hy3" or "lua:columns",
}
---@type HL.ConfigOpt.Input
config.input      = {
        follow_mouse       = 1,
        force_no_accel     = true,
        kb_layout          = "us, ru",
        numlock_by_default = true,
        sensitivity        = 0,
        touchpad           = { disable_while_typing = true, drag_lock = true, natural_scroll = false },
}
---@type HL.ConfigOpt.Cursor
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
---@type HL.ConfigOpt.Group
config.group      = {
        auto_group               = true,
        drag_into_group          = 2,
        merge_groups_on_drag     = false,
        merge_groups_on_groupbar = true,
        insert_after_current     = true,
        focus_removed_window     = true,
        col                      = {
                border_active          = groups.groupBorderInactive,
                border_inactive        = groups.groupBorderActive,
                border_locked_active   = groups.groupBorderInactiveLocked,
                border_locked_inactive = groups.groupBorderActiveLocked,
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
                text_color       = groups.groupBarActiveText,
                col              = {
                        active          = groups.groupBarActive,
                        inactive        = groups.groupBarInactive,
                        locked_active   = groups.groupBarActiveLocked,
                        locked_inactive = groups.groupBarInactiveLocked,
                },
        },
}
---@type HL.ConfigOpt.Decoration
config.decoration = {
        motion_blur        = { enabled = true, samples = 10 },
        rounding           = 0,
        inactive_opacity   = 1,
        fullscreen_opacity = 1,
        dim_inactive       = true,
        dim_strength       = 0.25,
        screen_shader      = "",
        shadow             = {
                enabled = false,
                range   = -2,
                sharp   = true,
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
---@type HL.ConfigOpt.Misc
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
---@type HL.ConfigOpt.Xwayland
config.xwayland   = {
        force_zero_scaling = true,
}
---@type HL.ConfigOpt.Binds
config.binds      = {
        workspace_center_on              = true,
        allow_workspace_cycles           = true,
        hide_special_on_workspace_change = true,
        movefocus_cycles_fullscreen      = true,
}
---@type HL.ConfigOpt.OpenGL
config.opengl     = {
        nvidia_anti_flicker = true,
}
---@type HL.ConfigOpt.Ecosystem
config.ecosystem  = {
        no_update_news  = true,
        no_donation_nag = true,
}
---@type HL.ConfigOpt.Debug
config.debug      = {
        disable_logs    = false,
        damage_tracking = 0,
        suppress_errors = false,
}
---@type HL.ConfigOpt.Scrolling
config.scrolling  = {
        column_width     = 0.9,
        focus_fit_method = 1,
}
---@type HL.Plugin
config.plugin     = {
        hy3             = {
                node_collapse_policy = 1,
                group_inset          = 10,
                tab_first_window     = false,
                tabs                 = {
                        height       = 20,
                        padding      = 0,
                        from_top     = true,
                        radius       = 0,
                        border_width = 0,
                        text_font    = "Monocraft",
                        text_height  = 10,
                        text_padding = 0,
                        colors       = {
                                active        = colors.crust,
                                active_text   = colors.text,
                                active_border = colors.crust,

                                focused        = colors.crust,
                                focused_text   = colors.surface2,
                                focused_border = colors.crust,

                                inactive        = colors.base,
                                inactive_text   = colors.surface2,
                                inactive_border = colors.base,

                                urgent        = colors.red,
                                urgent_text   = colors.crust,
                                urgent_border = colors.red,

                                locked        = colors.surface0,
                                locked_text   = colors.text,
                                locked_border = colors.surface0,
                        },
                },
        },
        dynamic_cursors = {
                enabled    = true,
                mode       = "rotate",
                threshold  = 1,
                rotate     = {
                        length = 20,
                        offset = 20.0,
                },
                tilt       = {
                        limit      = 1000,
                        activation = "negative_quadratic",
                        window     = 100,
                        full       = 60,
                },
                stretch    = {
                        limit      = 100,
                        activation = "negative_quadratic",
                        window     = 100,
                },
                shake      = {
                        enabled   = true,
                        threshold = 4.0,
                        base      = 4.0,
                        speed     = 1.0,
                        influence = 1.0,
                        limit     = 0.0,
                        timeout   = 0,
                        effects   = true,
                        ipc       = false,
                },
                hyprcursor = {
                        nearest    = 1,
                        enabled    = true,
                        resolution = -1,
                        fallback   = "clientside",
                },
        },
}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
hl.config(config)
hl.plugin.dynamic_cursors.shape_rule { shape = "text", mode = "tilt" }
