local HOME = os.getenv("HOME")

local envs = {
        { "XCURSOR_SIZE",                        "20" },
        { "XCURSOR_THEME",                       "catppuccin-mocha-red" },
        { "HYPRCURSOR_SIZE",                     "20" },
        { "HYPRCURSOR_THEME",                    "catppuccin-mocha-red" },

        { "EIDITOR",                             "nvim" },
        { "TERMINAL",                            "ghostty" },
        { "BROWSER",                             "librewolf" },
        { "SCRIPTS",                             HOME .. "/.local/bin" },

        ---- NVIDIA ------------------------------------------------------------------------------------------------------------------------

        { "LIBVA_DRIVER_NAME",                   "nvidia" },
        { "__GLX_VENDOR_LIBRARY_NAME",           "nvidia" },
        { "__GL_VRR_ALLOWED",                    "1" },
        { "WLR_NO_HARDWARE_CURSORS",             "1" },
        { "WLR_DRM_NO_ATOMIC",                   "1" },

        { "XDG_CURRENT_DESKTOP",                 "Hyprland" },
        { "XDG_SESSION_TYPE",                    "wayland" },
        { "XDG_SESSION_DESKTOP",                 "Hyprland" },
        { "QT_QPA_PLATFORM",                     "wayland;xcb" },
        { "QT_QPA_PLATFORMTHEME",                "qt6ct" },
        { "QT_WAYLAND_DISABLE_WINDOWDECORATION", "1" },
        { "QT_AUTO_SCREEN_SCALE_FACTOR",         "1" },
        { "MOZ_ENABLE_WAYLAND",                  "1" },
        { "GDK_SCALE",                           "1" },

        ---- XDG ENV VARS ------------------------------------------------------------------------------------------------------------------

        { "XDG_STATE_HOME",                      HOME .. "/.local/state" },
        { "XDG_DATA_HOME",                       HOME .. "/.local/share" },
        { "XDG_CONFIG_HOME",                     HOME .. "/.config" },
        { "XDG_CACHE_HOME",                      HOME .. "/.cache" },

        { "XDG_DESKTOP_HOME",                    HOME .. "/Desktop" },
        { "XDG_DOCUMENTS_HOME",                  HOME .. "/Documents" },
        { "XDG_DOWNLOAD_HOME",                   HOME .. "/Downloads" },

        { "XDG_MUSIC_HOME",                      HOME .. "/Music" },
        { "XDG_PICTURES_HOME",                   HOME .. "/Pictures" },
        { "XDG_SCREENSHOTS_HOME",                HOME .. "/Screenshots" },
        { "XDG_TEMPLATES_HOME",                  HOME .. "/Templates" },
        { "XDG_VIDEOS_HOME",                     HOME .. "/Videos" },
}
for _, env in ipairs(envs) do
        return hl.env(env[1], env[2])
end
