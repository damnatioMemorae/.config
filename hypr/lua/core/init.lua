local modules = {
        "autostart",
        "monitor",
        "env",
}
for _, module in ipairs(modules) do
        require("lua.core." .. module)
end
