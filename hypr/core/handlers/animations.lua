local function makeCurve(curves)
        for _, curve in ipairs(curves) do
                if type(curve[2]) == "table" then
                        hl.curve(curve[1], curve[2])
                end
        end
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
        local bezier     = curves.bezier
        local spring     = curves.spring

        for _, curve in ipairs(bezier) do
                makeCurve(curve)
                makeAnim(animations)
        end
        for _, curve in ipairs(spring) do
                makeCurve(curve)
                makeAnim(animations)
        end
end
