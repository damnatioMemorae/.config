local loads = {
        "config",
        "layouts",
}
for _, load in ipairs(loads) do
        require("lua." .. load)
end
