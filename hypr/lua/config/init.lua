local configs = {
        "animations",
        "keymaps",
        "options",
        "rules",
        "theme",
}
for _, config in ipairs(configs) do
        require("lua.config." .. config)
end
