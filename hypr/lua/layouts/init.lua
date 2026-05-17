local layouts = {
        "grid",
        "manual",
        "spiral",
        "columns",
}
for _, layout in ipairs(layouts) do
        require("lua.layouts." .. layout)
end
