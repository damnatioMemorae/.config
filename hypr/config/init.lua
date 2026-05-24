-- home/hypr/.config/hypr/config/init.lua

local Utils = require("lib.utils") ---@class Utils

--- @class Config.Nvidia
--- @field enable boolean Enable NVIDIA-specific fixes and env vars (default: false)
--- @field backend string GBM backend name, e.g. "nvidia-drm" or "nvidia-open" (default: "nvidia-drm")

--- @class Config.Cursor
--- @field theme string Xcursor theme name (default: "xcursor-bibata-original-classic")
--- @field hypr_theme string Hyprcursor theme name (default: "hyprcursor-bibata-original-classic")
--- @field size integer Cursor size in pixels (default: 24)

--- @class Config.App
--- @field term string Terminal emulator command (default: "kitty")
--- @field editor string Editor command (default: "nvim")
--- @field gui_file_manager string GUI file manager command (default: "dolphin")
--- @field tui_file_manager string TUI file manager command (default: "yazi")
--- @field menu string Menu binary (default: "rofi")
--- @field menu_cmd string Full app-launcher invocation (default: "rofi -name rofiMenu")
--- @field dmenu_cmd string Full dmenu-picker invocation (default: "rofi -name rofiDmenu -i -dmenu")
--- @field display_manager string Display/monitor manager command (default: "wdisplays")

--- @class Config.Monitor
--- @field id integer|nil Monitor id as reported by Hyprland
--- @field name string|nil Monitor name as reported by Hyprland
--- @field description string|nil Monitor description string as reported by Hyprland
--- @field mode string Resolution and refresh rate, e.g. "2560x1440@144"
--- @field position string Position in the virtual desktop, e.g. "1920x0"
--- @field scale number DPI scale factor
--- @field transform integer|nil Transform (rotation), e.g. 3 for 270°

--- @class Config
--- @field leader string Modifier key for keybinds (default: "SUPER")
--- @field theme string Name of the theme file in ./theme/themes/ (default: "oasis_moonlight")
--- @field ws_per_monitor integer Workspaces assigned per monitor on startup (default: 5)
--- @field persistent_workspaces integer|boolean Workspaces to pin per monitor, or false to disable (default: 5)
--- @field vim_mode boolean Use H/J/K/L as directional inputs in keybinds (default: true)
--- @field use_uwsm boolean Enable uwsm session management (default: false)
--- @field drm_devices string|nil DRM device path(s) for WLR_DRM_DEVICES; nil  = unset (default: nil)
--- @field is_laptop boolean|nil Whether the system running is a laptop or desktop (default: nil)
--- @field nvidia Config.Nvidia
--- @field cursor Config.Cursor
--- @field app Config.App
--- @field monitors Config.Monitor[] Ordered list of monitors; position in list maps to jump index 1–9
--- @field devices HL.DeviceSpec[] Per-device configs applied via hl.device() on startup (default: {})
local Config = {}

Config.defaults = {
        leader                = "SUPER",
        theme                 = "oasis_moonlight",
        ws_per_monitor        = 5,
        persistent_workspaces = 5,
        vim_mode              = true,
        use_uwsm              = false,
        drm_devices           = nil,
        is_laptop             = nil,
        nvidia                = {
                enable  = nil,
                backend = nil,
        },
        cursor                = {
                theme      = "xcursor-bibata-original-classic",
                hypr_theme = "hyprcursor-bibata-original-classic",
                size       = 24,
        },
        app                   = {
                term             = "kitty",
                editor           = "nvim",
                gui_file_manager = "dolphin",
                tui_file_manager = "yazi",
                menu             = "rofi",
                menu_cmd         = nil,
                dmenu_cmd        = nil,
                display_manager  = "wdisplays",
        },
        monitors              = {}, --- @type Config.Monitor[]
        devices               = {}, --- @type HL.DeviceSpec[]
}

--- @return boolean
local function detectNvidia()
        local f = io.open("/dev/nvidia0", "r")
        if f then
                f:close(); return true
        end
        local m = io.open("/sys/module/nvidia/version", "r")
        if m then
                m:close(); return true
        end
        return false
end

--- @return string
local function detectNvidiaBackend()
        local f = io.open("/proc/driver/nvidia/version", "r")
        if f then
                local v = f:read("*a"); f:close()
                if v:match("Open") then return "nvidia-open" end
        end
        return "nvidia-drm"
end

--- @return boolean|nil
local function detectIsLaptop()
        for _, mon in ipairs(hl.get_monitors()) do
                if mon.name:sub(1, 4) == "eDP-" then return true end
        end

        -- hl.get_monitors() may return empty at initial startup before Hyprland is ready;
        -- fall back to kernel DRM connector list
        local drm = io.popen("ls /sys/class/drm/ 2>/dev/null")
        if drm then
                for entry in drm:lines() do
                        if entry:match("^card%d+%-eDP") then
                                drm:close()
                                return true
                        end
                end
                drm:close()
        end

        return false
end

--- @param monitors Config.Monitor[]|fun(is_laptop: boolean|nil): Config.Monitor[]
--- @param isLaptop boolean|nil
--- @return Config.Monitor[]
local function resolveMonitors(monitors, isLaptop)
        if type(monitors) == "function" then return monitors(isLaptop) end

        return monitors
end

--- @param app Config.App
local function fillMenuCmds(app)
        local m = app.menu
        if not app.menu_cmd then app.menu_cmd = m .. " -name rofiMenu" end
        if not app.dmenu_cmd then app.dmenu_cmd = m .. " -name rofiDmenu -i -dmenu" end
end

--- @param cfg table
local function derive(cfg)
        if cfg.is_laptop == nil then cfg.is_laptop = detectIsLaptop() end
        if cfg.nvidia.enable == nil then
                cfg.nvidia.enable = detectNvidia()
                if cfg.nvidia.enable and cfg.nvidia.backend == nil then
                        cfg.nvidia.backend = detectNvidiaBackend()
                end
        end
        if cfg.nvidia.backend == nil then cfg.nvidia.backend = "nvidia-drm" end
        cfg.monitors = resolveMonitors(cfg.monitors, cfg.is_laptop)
        fillMenuCmds(cfg.app)
end

--- @param devices HL.DeviceSpec[]
local function setDeviceSettings(devices)
        for _, device in ipairs(devices) do
                hl.device(device)
        end
end

--- @param patch table
--- @return Config
Config.update = function(patch)
        Utils.deepExtend(Config, patch)
        derive(Config)

        return Config
end

--- @param overrides table|nil
--- @return Config
Config.merge = function(overrides)
        local merged = Utils.deepExtend({}, Config.defaults)
        if overrides then Utils.deepExtend(merged, overrides) end
        derive(merged)
        for k, v in pairs(merged) do
                Config[k] = v
        end

        return Config
end

--- @param overrides table|nil
--- @return Config
Config.setup = function(overrides)
        Config = Config.merge(overrides)
        hl.on("hyprland.start", require("config.autostart"))
        require("config.env")
        require("keymaps")
        require("config.general")
        setDeviceSettings(Config.devices)
        require("config.rules")
        require("config.monitors")
        require("theme")
        require("extensions")

        return Config
end

return Config
