-- Hyprland 0.56+ configuration.
-- Session processes are owned by UWSM/systemd, not compositor callbacks.

local home = assert(os.getenv("HOME"), "HOME is not set")
local mainMod = "SUPER"
local terminal = "/usr/bin/ghostty +new-window -e fish"
local menu = home .. "/.config/rofi/bin/launcher_misc"

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

hl.config({
    general = {
        gaps_in = 6,
        gaps_out = 10,
        border_size = 1,
        col = {
            active_border = "rgba(75715eff)",
            inactive_border = "rgba(272822ff)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 6,
        active_opacity = 1.0,
        inactive_opacity = 0.9,
        shadow = { enabled = false },
        blur = {
            enabled = true,
            size = 6,
            passes = 2,
            vibrancy = 0.5,
        },
    },
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true,
    },
    group = {
        col = {
            border_active = "rgba(75715eff)",
            border_inactive = "rgba(272822ff)",
        },
        groupbar = {
            enabled = true,
            font_size = 8,
            height = 18,
        },
    },
    misc = {
        disable_hyprland_logo = true,
        force_default_wallpaper = 0,
        disable_splash_rendering = true,
    },
    input = {
        kb_layout = "jp",
        kb_model = "jp106",
        follow_mouse = 0,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
            tap_to_click = true,
            scroll_factor = 1.0,
        },
    },
})

-- Panasonic Let's Note CF-SZ6 touchpad; harmless when the device is absent.
hl.device({
    name = "synps/2-synaptics-touchpad",
    sensitivity = 0,
})

hl.curve("easeOutQuint", {
    type = "bezier",
    points = { { 0.23, 1 }, { 0.32, 1 } },
})
hl.curve("almostLinear", {
    type = "bezier",
    points = { { 0.5, 0.5 }, { 0.75, 1 } },
})
hl.animation({
    leaf = "windows", enabled = true, speed = 3, bezier = "easeOutQuint",
})
hl.animation({
    leaf = "windowsIn", enabled = true, speed = 3,
    bezier = "easeOutQuint", style = "popin 90%",
})
hl.animation({
    leaf = "windowsOut", enabled = true, speed = 3,
    bezier = "easeOutQuint", style = "popin 90%",
})
hl.animation({
    leaf = "fade", enabled = true, speed = 4, bezier = "almostLinear",
})
hl.animation({
    leaf = "workspaces", enabled = true, speed = 3,
    bezier = "easeOutQuint", style = "slide",
})

hl.layer_rule({
    name = "blur-waybar",
    match = { namespace = "waybar" },
    blur = true,
    ignore_alpha = 0.20,
})
hl.layer_rule({
    name = "blur-mako",
    match = { namespace = "mako" },
    blur = true,
    ignore_alpha = 0.20,
})
hl.layer_rule({
    name = "blur-rofi",
    match = { namespace = "rofi" },
    blur = true,
    ignore_alpha = 0.00,
})

-- Applications and session controls.
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Return",
    hl.dsp.exec_cmd("google-chrome-stable"))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("uwsm stop"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(mainMod .. " + SHIFT + S",
    hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy --type image/png]]))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + R",
    hl.dsp.exec_cmd(
        "hyprctl reload && systemctl --user reload-or-restart waybar.service"
    ))

local focusKeys = {
    J = "left", K = "down", L = "up", semicolon = "right",
    left = "left", down = "down", up = "up", right = "right",
}
for key, direction in pairs(focusKeys) do
    hl.bind(mainMod .. " + " .. key,
        hl.dsp.focus({ direction = direction }))
    hl.bind(mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ direction = direction }))
end

hl.bind(mainMod .. " + H", hl.dsp.layout("preselect r"))
hl.bind(mainMod .. " + V", hl.dsp.layout("preselect d"))
hl.bind(mainMod .. " + F",
    hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + S", hl.dsp.group.toggle())
hl.bind(mainMod .. " + W", hl.dsp.group.toggle())
hl.bind(mainMod .. " + E", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SHIFT + space",
    hl.dsp.window.float({ action = "toggle" }))

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    local resizeKeys = {
        J = { -10, 0 }, left = { -10, 0 },
        K = { 0, 10 }, down = { 0, 10 },
        L = { 0, -10 }, up = { 0, -10 },
        semicolon = { 10, 0 }, right = { 10, 0 },
    }
    for key, delta in pairs(resizeKeys) do
        hl.bind(key, hl.dsp.window.resize({
            x = delta[1], y = delta[2], relative = true,
        }), { repeating = true })
    end
    hl.bind("Return", hl.dsp.submap("reset"))
    hl.bind("Escape", hl.dsp.submap("reset"))
    hl.bind(mainMod .. " + R", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl set +5%"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl set 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true })
hl.bind(mainMod .. " + SHIFT + comma",
    hl.dsp.exec_cmd("playerctl previous"))
hl.bind(mainMod .. " + SHIFT + period",
    hl.dsp.exec_cmd("playerctl next"))
hl.bind(mainMod .. " + SHIFT + backslash",
    hl.dsp.exec_cmd("playerctl play-pause"))

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})
hl.window_rule({
    name = "float-waybar-nmtui",
    match = { class = "^com.noy.nmtui$" },
    float = true,
})
