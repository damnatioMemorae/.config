local M = {}
--------------------------------------------------------------------------------------------------------------------------------------------

function M.bulk(t, fun)
        for _, item in ipairs(t) do
                fun()
        end
end

function M.keymap(lhs, rhs, opts)
        opts = opts or {}
        if type(lhs) == "table" then
                for _, key in pairs(lhs) do
                        hl.bind(key, rhs, opts)
                end
        else
                hl.bind(lhs, rhs, opts)
        end
end

--------------------------------------------------------------------------------------------------------------------------------------------
return M
