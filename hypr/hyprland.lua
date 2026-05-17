local modules = {
        "core",
        "config",
        "layouts",
}
for _, module in ipairs(modules) do
        require("lua." .. module)
end
