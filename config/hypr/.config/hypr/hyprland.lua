------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "rofi -show drun"


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
    hl.exec_cmd("hyprpaper")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Add these later once you've actually chosen cursor themes:
-- hl.env("XCURSOR_THEME", "...")
-- hl.env("HYPRCURSOR_THEME", "...")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 2,
	col = {
	    active_border = {
		colors = {
		    "rgba(2d0a4dff)",
		    "rgba(9412c7ff)",
		    "rgba(cb5dffff)",
		},
		angle = 35,
	    },

	    inactive_border = "rgba(40334aaa)",
	},
        resize_on_border = true,
        allow_tearing    = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 8,
        rounding_power = 3,

        active_opacity   = 1,
        inactive_opacity = 1,

	dim_inactive = true,
	dim_strength = 0.08,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },

    binds = {
        workspace_back_and_forth = true,
    },
})


--------------------
---- ANIMATIONS ----
--------------------

hl.curve(
    "easeOutQuint",
    {
        type = "bezier",
        points = {
            { 0.23, 1 },
            { 0.32, 1 },
        },
    }
)

hl.curve(
    "easeInOutCubic",
    {
        type = "bezier",
        points = {
            { 0.65, 0.05 },
            { 0.36, 1 },
        },
    }
)

hl.curve(
    "linear",
    {
        type = "bezier",
        points = {
            { 0, 0 },
            { 1, 1 },
        },
    }
)

hl.curve(
    "almostLinear",
    {
        type = "bezier",
        points = {
            { 0.5, 0.5 },
            { 0.75, 1 },
        },
    }
)

hl.curve(
    "quick",
    {
        type = "bezier",
        points = {
            { 0.15, 0 },
            { 0.1, 1 },
        },
    }
)

hl.curve(
    "easy",
    {
        type       = "spring",
        mass       = 1,
        stiffness  = 238.1191,
        dampening  = 24.21279333,
    }
)

hl.animation({
    leaf    = "global",
    enabled = true,
    speed   = 10,
    bezier  = "default",
})

hl.animation({
    leaf    = "border",
    enabled = true,
    speed   = 5.39,
    bezier  = "easeOutQuint",
})

hl.animation({
    leaf    = "windows",
    enabled = true,
    speed   = 4.79,
    spring  = "easy",
})

hl.animation({
    leaf    = "windowsIn",
    enabled = true,
    speed   = 4.1,
    spring  = "easy",
    style   = "popin 87%",
})

hl.animation({
    leaf    = "windowsOut",
    enabled = true,
    speed   = 1.49,
    bezier  = "linear",
    style   = "popin 87%",
})

hl.animation({
    leaf    = "fadeIn",
    enabled = true,
    speed   = 1.73,
    bezier  = "almostLinear",
})

hl.animation({
    leaf    = "fadeOut",
    enabled = true,
    speed   = 1.46,
    bezier  = "almostLinear",
})

hl.animation({
    leaf    = "fade",
    enabled = true,
    speed   = 3.03,
    bezier  = "quick",
})

hl.animation({
    leaf    = "layers",
    enabled = true,
    speed   = 3.81,
    bezier  = "easeOutQuint",
})

hl.animation({
    leaf    = "layersIn",
    enabled = true,
    speed   = 4,
    bezier  = "easeOutQuint",
    style   = "fade",
})

hl.animation({
    leaf    = "layersOut",
    enabled = true,
    speed   = 1.5,
    bezier  = "linear",
    style   = "fade",
})

hl.animation({
    leaf    = "workspaces",
    enabled = true,
    speed   = 1.94,
    bezier  = "almostLinear",
    style   = "fade",
})


----------------------
---- WINDOW RULES ----
----------------------

hl.window_rule({
    name = "system-monitor",

    match = {
        class = "^system-monitor$",
    },

    float = true,
    center = true,

    size = {
        "(monitor_w*0.70)",
        "(monitor_h*0.70)",
    },
})

hl.window_rule({
    name = "network-manager",

    match = {
        class = "^network-manager$",
    },

    float = true,
    center = true,

    size = {
        "(monitor_w*0.65)",
        "(monitor_h*0.65)",
    },
})

hl.window_rule({
    name = "volume-control",

    match = {
        class = "org.pulseaudio.pavucontrol",
    },

    float = true,
    center = true,

    size = {
        "(monitor_w*0.45)",
        "(monitor_h*0.55)",
    },
})

----------------
---- LAYOUT ----
----------------

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
    scrolling = {
        fullscreen_on_one_column = true,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "gb",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll       = false,
            tap_to_click         = true,
            disable_while_typing = true,
        },
    },
})


----------------
---- GESTURE ----
----------------

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"


-- INTERNET
hl.bind(
    mainMod .. "+ I",
    hl.dsp.exec_cmd("firefox -p default-release")
)

-- Lock
hl.bind(
    mainMod .. "+ ALT + L",
    hl.dsp.exec_cmd("hyprlock")
)

-- Programs
hl.bind(
    mainMod .. " + Return",
    hl.dsp.exec_cmd(terminal)
)

hl.bind(
    mainMod .. " + Space",
    hl.dsp.exec_cmd(menu)
)

hl.bind(
    mainMod .. " + SHIFT + Space",
    hl.dsp.exec_cmd("rofi -show projects -modes \"projects:$HOME/.local/bin/projector\" -kb-custom-1 \"Alt+Return\"")
)

hl.bind(
    mainMod .. " + SHIFT + T",
    hl.dsp.exec_cmd("rofi -show todos -modes \"todos:$HOME/.local/bin/todos\"")
)

hl.bind(
    mainMod .. " + E",
    hl.dsp.exec_cmd(fileManager)
)

-- Clip History
hl.exec_cmd("wl-paste --type text --watch cliphist store")
hl.exec_cmd("wl-paste --type image --watch cliphist store")

hl.bind(
    mainMod .. " + SHIFT + S",
    hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy")
)

-- Windows
hl.bind(
    mainMod .. " + Q",
    hl.dsp.window.close()
)

hl.bind(
    mainMod .. " + V",
    hl.dsp.window.float({
        action = "toggle",
    })
)

hl.bind(
    mainMod .. " + F",
    hl.dsp.window.fullscreen({
        action = "toggle",
        mode   = "fullscreen",
    })
)

-- Hyprland shutdown / exit
hl.bind(
    mainMod .. " + M",
    hl.dsp.exec_cmd(
        "command -v hyprshutdown >/dev/null 2>&1 " ..
        "&& hyprshutdown " ..
        "|| hyprctl dispatch exit"
    )
)

-- Dwindle controls
hl.bind(
    mainMod .. " + P",
    hl.dsp.window.pseudo()
)

hl.bind(
    mainMod .. " + T",
    hl.dsp.layout("togglesplit")
)

----------------
---- FOCUS ----
----------------

hl.bind(
    mainMod .. " + H",
    hl.dsp.focus({ direction = "left" })
)

hl.bind(
    mainMod .. " + J",
    hl.dsp.focus({ direction = "down" })
)

hl.bind(
    mainMod .. " + K",
    hl.dsp.focus({ direction = "up" })
)

hl.bind(
    mainMod .. " + L",
    hl.dsp.focus({ direction = "right" })
)

-- Keep arrow versions too
hl.bind(
    mainMod .. " + left",
    hl.dsp.focus({ direction = "left" })
)

hl.bind(
    mainMod .. " + right",
    hl.dsp.focus({ direction = "right" })
)

hl.bind(
    mainMod .. " + up",
    hl.dsp.focus({ direction = "up" })
)

hl.bind(
    mainMod .. " + down",
    hl.dsp.focus({ direction = "down" })
)


----------------------
---- MOVE WINDOWS ----
----------------------

hl.bind(
    mainMod .. " + SHIFT + H",
    hl.dsp.window.move({ direction = "left" })
)

hl.bind(
    mainMod .. " + SHIFT + J",
    hl.dsp.window.move({ direction = "down" })
)

hl.bind(
    mainMod .. " + SHIFT + K",
    hl.dsp.window.move({ direction = "up" })
)

hl.bind(
    mainMod .. " + SHIFT + L",
    hl.dsp.window.move({ direction = "right" })
)


--------------------
---- WORKSPACES ----
--------------------

for i = 1, 10 do
    local key = i % 10

    hl.bind(
        mainMod .. " + " .. key,
        hl.dsp.focus({
            workspace = i,
        })
    )

    hl.bind(
        mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({
            workspace = i,
        })
    )
end


------------------
---- SCRATCHPAD ---
------------------

hl.bind(
    mainMod .. " + S",
    hl.dsp.workspace.toggle_special("magic")
)

hl.bind(
    mainMod .. " + SHIFT + S",
    hl.dsp.window.move({
        workspace = "special:magic",
    })
)


--------------------
---- MOUSE BINDS ----
--------------------

hl.bind(
    mainMod .. " + mouse_down",
    hl.dsp.focus({
        workspace = "e+1",
    })
)

hl.bind(
    mainMod .. " + mouse_up",
    hl.dsp.focus({
        workspace = "e-1",
    })
)

hl.bind(
    mainMod .. " + mouse:272",
    hl.dsp.window.drag(),
    {
        mouse = true,
    }
)

hl.bind(
    mainMod .. " + mouse:273",
    hl.dsp.window.resize(),
    {
        mouse = true,
    }
)


---------------------
---- MEDIA KEYS -----
---------------------

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd(
        "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
    ),
    {
        locked    = true,
        repeating = true,
    }
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd(
        "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ),
    {
        locked    = true,
        repeating = true,
    }
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd(
        "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ),
    {
        locked    = true,
        repeating = true,
    }
)

hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd(
        "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ),
    {
        locked    = true,
        repeating = true,
    }
)

hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd(
        "brightnessctl -e4 -n2 set 5%+"
    ),
    {
        locked    = true,
        repeating = true,
    }
)

hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd(
        "brightnessctl -e4 -n2 set 5%-"
    ),
    {
        locked    = true,
        repeating = true,
    }
)

hl.bind(
    "XF86AudioNext",
    hl.dsp.exec_cmd("playerctl next"),
    {
        locked = true,
    }
)

hl.bind(
    "XF86AudioPause",
    hl.dsp.exec_cmd("playerctl play-pause"),
    {
        locked = true,
    }
)

hl.bind(
    "XF86AudioPlay",
    hl.dsp.exec_cmd("playerctl play-pause"),
    {
        locked = true,
    }
)

hl.bind(
    "XF86AudioPrev",
    hl.dsp.exec_cmd("playerctl previous"),
    {
        locked = true,
    }
)


----------------------
---- WINDOW RULES ----
----------------------

hl.window_rule({
    name  = "suppress-maximize-events",

    match = {
        class = ".*",
    },

    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",

    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})



---------------
---- MUSIC ----
---------------

local music_workspace = "music"
local music_class = "ytm"

hl.window_rule({
    name = "youtube-music",

    match = {
        class = music_class,
    },

    float = true,
    workspace = "special:" .. music_workspace,

    size = {
        "(monitor_w*0.25)",
        "(monitor_h*0.75)",
    },

    move = {
        "(monitor_w-window_w-(window_w/1.2))",
        "((monitor_h-window_h)/5)",
    },
})

hl.bind("SUPER + M", function()
    local windows = hl.get_windows({
        class = music_class,
    })

    if #windows == 0 then
        hl.dispatch(
            hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/ytm")
        )
        return
    end

    hl.dispatch(
        hl.dsp.workspace.toggle_special(music_workspace)
    )
end, {
    description = "Toggle YouTube Music",
})
