local cmds = {
        "gsettings set org.gnome.desktop.interface gtk-theme           'catppuccin-mocha-red-standard+default'",
        "gsettings set org.gnome.desktop.interface color-scheme        'prefer-dark'",
        "hyprctl setcursor catppuccin-mocha-red                        20",
        "gsettings set org.gnome.desktop.interface cursor-theme        catppuccin-mocha-red",
        "gsettings set org.gnome.desktop.interface cursor-size         20",
        "gsettings set org.gnome.desktop.interface font-name           'Monocraft 10'",
        "gsettings set org.gnome.desktop.interface document-font-name  'Monocraft 10'",
        "gsettings set org.gnome.desktop.interface monospace-font-name 'Monocraft 10'",
        "gsettings set org.gnome.desktop.interface font-antialiasing   'rgba'",
        "gsettings set org.gnome.desktop.interface font-hinting        'full'",
}
for _, cmd in ipairs(cmds) do
        hl.exec_cmd(cmd)
end
