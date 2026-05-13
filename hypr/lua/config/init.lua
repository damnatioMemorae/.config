local configs = {
        "autostart",
        "animations",
        "env",
        "keymaps",
        "monitor",
        "options",
        "rules",
        "theme",
}
for _, config in ipairs(configs) do
        require("config." .. config)
end
