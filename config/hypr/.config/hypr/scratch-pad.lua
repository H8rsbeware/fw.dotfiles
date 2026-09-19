-- ---------------------------------------------------------------------------
-- Padding / scratch windows
-- ---------------------------------------------------------------------------

local PAD_CLASS = "hypr-pad"

-- Dwindle ratio:
--   1.0 = 50 / 50
--   0.4 = 20 / 80
--   1.3 = 65 / 35
local PAD_LEFT_RATIO  = 0.4
local PAD_RIGHT_RATIO = 1.3

-- Tracks which preset each workspace is currently using.
local padding_side = {}


hl.config({
    dwindle = {
        preserve_split = true,
        split_bias = 0,
        use_active_for_splits = true,
    },
})


-- ---------------------------------------------------------------------------
-- Padding window rule
-- ---------------------------------------------------------------------------

hl.window_rule({
    name = "padding-window",
    match = {
        class = "^" .. PAD_CLASS .. "$",
    },

    tile = true,
    no_initial_focus = true,
})


-- ---------------------------------------------------------------------------
-- Helpers
-- ---------------------------------------------------------------------------

local function active_workspace_id()
    local workspace = hl.get_active_workspace()

    if workspace == nil then
        return nil
    end

    return workspace.id
end


local function set_padding_side(side)
    local workspace_id = active_workspace_id()

    if workspace_id == nil then
        return
    end

    local current_side = padding_side[workspace_id]

    -- If we're changing sides, exchange the two halves of the current
    -- Dwindle split first.
    if current_side ~= nil and current_side ~= side then
        hl.dispatch(hl.dsp.layout("swapsplit"))
    end

    if side == "left" then
        -- ┌──────┬────────────────────┐
        -- │ pad  │ main               │
        -- │ 20%  │ 80%                │
        -- └──────┴────────────────────┘
        hl.dispatch(
            hl.dsp.layout(
                "splitratio " .. PAD_LEFT_RATIO .. " exact"
            )
        )

    elseif side == "right" then
        -- ┌─────────────────┬─────────┐
        -- │ main            │ pad     │
        -- │ 65%             │ 35%     │
        -- └─────────────────┴─────────┘
        hl.dispatch(
            hl.dsp.layout(
                "splitratio " .. PAD_RIGHT_RATIO .. " exact"
            )
        )
    end

    padding_side[workspace_id] = side
end


local function open_padding(command)
    -- The next tiled window gets inserted to the LEFT of the currently
    -- focused window.
    hl.dispatch(hl.dsp.layout("preselect l"))

    -- Run externally rather than blocking Hyprland's Lua event loop.
    hl.dispatch(hl.dsp.exec_cmd(command))
end

-- ---------------------------------------------------------------------------
-- Initialise new padding windows
-- ---------------------------------------------------------------------------

hl.on("window.open", function(window)
    if window.class ~= PAD_CLASS then
        return
    end

    -- no_initial_focus means the original/main application should still be
    -- active, so splitratio operates on the pair we just created.
    local workspace_id = active_workspace_id()

    if workspace_id == nil then
        return
    end

    hl.dispatch(
        hl.dsp.layout(
            "splitratio " .. PAD_LEFT_RATIO .. " exact"
        )
    )

    padding_side[workspace_id] = "left"
end)

hl.bind("SUPER + SHIFT + P", function()
    local home = os.getenv("HOME")

    open_padding(
        "kitty --class "
            .. PAD_CLASS
            .. " nvim "
            .. home
            .. "/.local/share/scratch.md"
    )
end)

-- ---------------------------------------------------------------------------
-- Keybinds
-- ---------------------------------------------------------------------------

-- Pad on the LEFT at 20%.
hl.bind("SUPER + SHIFT + H", function()
    set_padding_side("left")
end)

-- Pad on the RIGHT at 35%.
hl.bind("SUPER + SHIFT + L", function()
    set_padding_side("right")
end)


