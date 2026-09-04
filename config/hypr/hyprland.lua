hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@60",
    position = "auto",
    scale = 1,
    mirror = "eDP-1",
})

hl.monitor({
    output = "eDP-1",
    mode = "1920x1080@60.00Hz",
    position = "0x0",
    scale = 1.2,
    cm = "srgb",
})

local terminal = "alacritty"
local fileManager = "nautilus"
local menu = "rofi -show drun"

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("dunst")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)

hl.env("XCURSOR_SIZE", "32")
hl.env("HYPRCURSOR_SIZE", "32")

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 12,
        border_size = 0,
        col = {
            active_border = 0xffffffff,
            inactive_border = 0xff444444,
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
})

hl.config({
    decoration = {
        rounding = 15,
        rounding_power = 4,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
})

hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear", { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("almostLinear", { type = "bezier", points = { {0.5, 0.5}, {0.75, 1} } })
hl.curve("quick", { type = "bezier", points = { {0.15, 0}, {0.1, 1} } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 4.2, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = true,
    },
})

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        accel_profile = "flat",
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.2,
})

local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + CTRL + M", hl.dsp.exec_cmd([[command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit]]))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]]))
hl.bind("Print", hl.dsp.exec_raw([[grim -g "$(slurp)" ~/Pictures/Screenshots/shot-$(date +%Y%m%d-%H%M%S).png]]))

hl.bind(mainMod .. " + Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("hyprlock"))

hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.swap({ direction = "left" }))

for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 2"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 2"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move = "20 monitor_h-120",
    float = true,
})

hl.config({
    input = {
        sensitivity = 0.0,
    },
})

hl.unbind("XF86AudioRaiseVolume")
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd([[pamixer -i 2 && dunstify -a "Volume" -u normal -h int:value:$(pamixer --get-volume) -h string:x-dunst-stack-tag:volume "Volume" "$(pamixer --get-volume)%" ]]), { repeating = true })

hl.unbind("XF86AudioLowerVolume")
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd([[pamixer -d 2 && dunstify -a "Volume" -u normal -h int:value:$(pamixer --get-volume) -h string:x-dunst-stack-tag:volume "Volume" "$(pamixer --get-volume)%" ]]), { repeating = true })

hl.unbind("XF86MonBrightnessUp")
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd([[brightnessctl set 5%+ && dunstify -a "Brightness" -u normal -h int:value:$(brightnessctl -m | cut -d',' -f4 | tr -d '%') -h string:x-dunst-stack-tag:brightness "Brightness" "$(brightnessctl -m | cut -d',' -f4)" ]]), { repeating = true })

hl.unbind("XF86MonBrightnessDown")
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd([[brightnessctl set 5%- && dunstify -a "Brightness" -u normal -h int:value:$(brightnessctl -m | cut -d',' -f4 | tr -d '%') -h string:x-dunst-stack-tag:brightness "Brightness" "$(brightnessctl -m | cut -d',' -f4)" ]]), { repeating = true })
