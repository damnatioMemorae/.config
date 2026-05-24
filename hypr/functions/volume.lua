local M = {}
--------------------------------------------------------------------------------------------------------------------------------------------

local sh = require("core.sh")

function M.get(dev)
        local vol = sh("amixer", "sget", dev)
        hl.notification.create({ text = tostring(vol), timeout = 2000, color = "rgb(89dceb)", font_size = 12 })
        return vol
end

function M.up(dev, v)
        sh("amixer", "sset", dev, v .. "%+")
        M.get(dev)
end

--------------------------------------------------------------------------------------------------------------------------------------------
return M
