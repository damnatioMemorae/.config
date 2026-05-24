local M = {}
--------------------------------------------------------------------------------------------------------------------------------------------

local modifiers = {
        C = "CONTROL",
        A = "ALT",
        M = "ALT",
        S = "SHIFT",
        D = "SUPER",
}

local function parseKeys(keys)
        local body = keys:match("^<(.+)>$")
        if not body then
                return keys
        end

        local parsed = {}
        local key

        for part in body:gmatch("[^-]+") do
                local modifier = modifiers[part]

                if modifier then
                        table.insert(parsed, modifier)
                elseif not key then
                        key = part
                else
                        error("multiple keys in bind: " .. keys)
                end
        end

        assert(key, "missing key in bind: " .. keys)
        table.insert(parsed, key)

        return table.concat(parsed, " + ")
end

---@param keys string
---@param dispatcher HL.Dispatcher|function
---@param flags HL.BindOptions
function M.bind(keys, dispatcher, flags)
        if type(keys) == "table" then
                return M.bind(keys[1], keys[2], keys[3])
        end

        flags = flags or {}
        hl.bind(parseKeys(keys), dispatcher, flags)
end

function M.getHostname()
        local f = io.popen("hostnamectl hostname")
        if f == nil then return "" end
        local hostname = f:read("l")
        f:close()
        return hostname
end

---@param hex string
function M.rgb(hex)
        hex = string.lower(hex)
        ret = string.sub(hex, 2)
        ret = "rgb(" .. ret .. ")"
        return ret
end

---@param dir string
---@return table
function M.ls(dir)
        local i, t, popen = 0, {}, io.popen
        local pfile = popen("ls -a '" .. dir .. "'")
        for filename in pfile:lines() do
                i    = i + 1
                t[i] = filename
        end
        pfile:close()
        table.remove(t, 1)
        table.remove(t, 1)
        return t
end

--------------------------------------------------------------------------------------------------------------------------------------------
return M
