local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

config.char_select_font_size = 13.0
config.color_scheme = "tokyonight_storm"
config.colors = {
    background = "black",
    foreground = "white",
}
config.disable_default_key_bindings = true
config.enable_scroll_bar = true
config.font = wezterm.font_with_fallback({ "JetBrains Mono", "JetBrainsMonoNerdFontMono", "MesloLGS NF" })
config.font_size = 11.0
config.hide_tab_bar_if_only_one_tab = true
config.keys = {
    {
        key = "|",
        mods = "CTRL|ALT|SHIFT",
        action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "-",
        mods = "CTRL|ALT",
        action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "x",
        mods = "CTRL|ALT",
        action = act.CloseCurrentPane({ confirm = true }),
    },
    {
        key = "h",
        mods = "CTRL|ALT",
        action = act.ActivatePaneDirection("Left"),
    },
    {
        key = "j",
        mods = "CTRL|ALT",
        action = act.ActivatePaneDirection("Down"),
    },
    {
        key = "k",
        mods = "CTRL|ALT",
        action = act.ActivatePaneDirection("Up"),
    },
    {
        key = "l",
        mods = "CTRL|ALT",
        action = act.ActivatePaneDirection("Right"),
    },
    {
        key = "-",
        mods = "CTRL",
        action = act.DecreaseFontSize,
    },
    {
        key = "+",
        mods = "CTRL|SHIFT",
        action = act.IncreaseFontSize,
    },
    {
        key = "0",
        mods = "CTRL",
        action = act.ResetFontSize,
    },
    {
        key = "c",
        mods = "CTRL|SHIFT",
        action = act.CopyTo("Clipboard"),
    },
    {
        key = "v",
        mods = "CTRL|SHIFT",
        action = act.PasteFrom("Clipboard"),
    },
    {
        key = "u",
        mods = "CTRL|SHIFT",
        action = act.CharSelect,
    },
}
config.window_background_opacity = 0.75

return config
