if hl.plugin.dynamic_cursors then
        hl.config{
                plugin = {
                        dynamic_cursors = {
                                enabled    = true,
                                mode       = "tilt",
                                threshold  = 1,
                                rotate     = {
                                        length = 20,
                                        offset = 0.0,
                                },
                                tilt       = {
                                        limit      = 1000,
                                        activation = "negative_quadratic",
                                        window     = 100,
                                        full       = 60,
                                },
                                stretch    = {
                                        limit      = 1000,
                                        activation = "linear",
                                        window     = 100,
                                },
                                shake      = {
                                        enabled   = true,
                                        threshold = 2.0,
                                        base      = 4.0,
                                        speed     = 2.0,
                                        influence = 0.0,
                                        limit     = 0.0,
                                        timeout   = 2000,
                                        effects   = false,
                                        ipc       = false,
                                },
                                hyprcursor = {
                                        nearest    = 1,
                                        enabled    = true,
                                        resolution = -1,
                                        fallback   = "clientside",
                                },
                        },
                },
        }
end
