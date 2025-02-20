local wezterm = require("wezterm")
local mux = wezterm.mux
local action = wezterm.action

local config = wezterm.config_builder()

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

config.term = "xterm-256color"
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true
config.color_scheme = "rose-pine"
config.window_background_opacity = 0.8

config.window_padding = {
	top = 10,
	bottom = 10,
	left = 10,
	right = 10,
}

config.window_frame = {
	font = wezterm.font({ family = "Roboto", weight = "Bold" }),
	font_size = 13.0,
}

config.colors = {
	tab_bar = {
		inactive_tab_edge = "#575757",
	},
	background = "#040404",
}

config.default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe", "--login" }

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = {
	{
		key = "-",
		mods = "LEADER",
		action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "LEADER",
		action = action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "l",
		mods = "LEADER",
		action = action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "j",
		mods = "LEADER",
		action = action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "k",
		mods = "LEADER",
		action = action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "m",
		mods = "LEADER",
		action = action.TogglePaneZoomState,
	},
	{
		key = "c",
		mods = "LEADER",
		action = action.SpawnTab("CurrentPaneDomain"),
	},

	{
		key = "p",
		mods = "LEADER",
		action = action.ActivateTabRelative(-1),
	},
	{
		key = "n",
		mods = "LEADER",
		action = action.ActivateTabRelative(1),
	},
	{ key = "[", mods = "LEADER", action = action.ActivateCopyMode },
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = action.ActivateTab(i - 1),
	})
end

return config
