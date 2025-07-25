local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

-- Appearance
config.color_scheme = "tokyonight_moon"
config.colors = {
    background = "black",
    foreground = "white",
}
config.window_background_opacity = 0.75

config.enable_scroll_bar = true

config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.show_new_tab_button_in_tab_bar = false

config.char_select_font_size = 13.0
config.font_size = 11.0
config.font = wezterm.font_with_fallback({
    "JetBrains Mono",
    "JetBrainsMonoNerdFontMono",
    "MesloLGS NF",
})

-- Shell detection
local shell = os.getenv("SHELL") or "/bin/bash"

-- Check whether tmux is available
local function tmux_available()
    return wezterm.run_child_process({ "tmux", "-V" })
end

-- If tmux is available, use it as the default program
-- and attach to or create the main session, else use detected shell
if tmux_available() then
    config.default_prog = {
        "tmux",
        "new",
        "-As",
        "main",
    }
else
    config.default_prog = { shell }
end

-- Fix terminal color handling
config.set_environment_variables = {
    TERM = "xterm-256color",
}

-- Honor kitty keyboard protocol escape sequences; allows forwarding of unusual keybindings
config.enable_kitty_keyboard = true

-- Key Bindings
config.disable_default_key_bindings = true
config.keys = {
    -- Debug overlay
    { key = "l", mods = "CTRL|SHIFT", action = act.ShowDebugOverlay },

    -- Font size
    { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
    { key = "+", mods = "CTRL|SHIFT", action = act.IncreaseFontSize },
    { key = "0", mods = "CTRL", action = act.ResetFontSize },

    -- Clipboard
    { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
    { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },

    -- Character selector
    { key = "u", mods = "CTRL|SHIFT", action = act.CharSelect },

    -- Launch into raw shell without tmux
    {
        key = "n",
        mods = "CTRL|ALT",
        action = act.SpawnCommandInNewTab({
            args = { shell },
        }),
    },

    -- Tab navigation
    { key = "h", mods = "CTRL|ALT", action = act.ActivateTabRelative(-1) },
    { key = "l", mods = "CTRL|ALT", action = act.ActivateTabRelative(1) },

    -- Close current tab in case you wanted to use a raw shell
    {
        key = "x",
        mods = "CTRL|ALT",
        action = act.CloseCurrentTab({ confirm = true }),
    },
}

return config
