local function makeCurve(curves)
        if type(curves) == "table" then
                for _, curve in ipairs(curves) do
                        hl.curve(curve[1], curve[2])
                end
                return
        end

        hl.curve(curves)
end

local function makeAnim(animations)
        for _, animation in ipairs(animations) do
                hl.animation({
                        leaf    = animation[1] or nil,
                        enabled = animation[2] or nil,
                        speed   = animation[3] or nil,
                        bezier  = animation[4] or nil,
                        style   = animation[5] or nil,
                })
        end
end

return function(spec)
        local animations = spec.animations
        local curves     = spec.curves

        makeCurve(curves)
        makeAnim(animations)
end
