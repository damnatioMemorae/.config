local monitors = {
        { "eDP-1", "1920x1080@144", "0x0", "1" },
}

for _, monitor in ipairs(monitors) do
        hl.monitor({
                output   = monitor[1],
                mode     = monitor[2],
                position = monitor[3],
                scale    = monitor[4],
        })
end
