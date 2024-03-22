-- TODO:
-- jump to spot in vim mode
-- select command output

local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- config.term = "wezterm"
config.color_scheme = "nightfox"
config.font_size = 14
config.audible_bell = "Disabled"
config.cursor_blink_rate = 0
config.enable_tab_bar = false
config.window_decorations = "RESIZE | MACOS_FORCE_DISABLE_SHADOW"
config.window_close_confirmation = "NeverPrompt"
config.quick_select_alphabet = "fjdkslavmeirucwo"

config.keys = {
	{
		key = "h",
		mods = "SUPER",
		action = wezterm.action.Nop,
	},
	{
		key = "k",
		mods = "SUPER",
		action = wezterm.action.Nop,
	},
	{
		key = "'",
		mods = "SUPER",
		action = wezterm.action.SpawnWindow,
		-- action = wezterm.action.SpawnCommandInNewWindow({cwd = "" }),
	},
	{
		key = "q",
		mods = "SUPER",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
	{
		key = "u",
		mods = "ALT",
		action = wezterm.action.ScrollByPage(-0.5),
	},
	{
		key = "d",
		mods = "ALT",
		action = wezterm.action.ScrollByPage(0.5),
	},
	{
		key = "v",
		mods = "ALT",
		action = wezterm.action.ActivateCopyMode,
	},
	{
		key = "/",
		mods = "ALT",
		action = wezterm.action.Search({ CaseInSensitiveString = "" }),
	},
	{
		key = "i",
		mods = "ALT",
		action = wezterm.action.CharSelect,
	},
	{
		key = "a",
		mods = "ALT",
		action = wezterm.action.QuickSelectArgs({
			label = "copy anywhere",
			patterns = { "[^ \"']+" },
			scope_lines = 0,
		}),
	},
	{
		key = "w",
		mods = "ALT",
		action = wezterm.action.QuickSelectArgs({
			label = "copy word",
			patterns = { "[A-Za-z0-9._-]+" },
			scope_lines = 0,
		}),
	},
	{
		key = "c",
		mods = "ALT",
		action = wezterm.action.QuickSelectArgs({
			label = "copy command",
			patterns = { "[^ >]+(?: [^ ]+)*" },
			scope_lines = 0,
		}),
	},
	-- {
	-- 	key = "o",
	-- 	mods = "ALT",
	-- 	action = wezterm.action.QuickSelectArgs({
	-- 		label = "copy output",
	-- 		patterns = { "(?sm:arch.*valid2)" },
	-- 		-- scope_lines = 0,
	-- 	}),
	-- },
	-- {
	-- 	key = "l",
	-- 	mods = "ALT",
	-- 	action = wezterm.action.QuickSelectArgs({
	-- 		label = "jump to line",
	-- 		patterns = { "[^ ].*$" },
	-- 		scope_lines = 0,
	-- 		action = wezterm.action.JumpToInCopyMode,
	-- 	}),
	-- },
	-- {
	{
		key = "b",
		mods = "ALT",
		action = wezterm.action.QuickSelectArgs({
			label = "open link in browser",
			patterns = {
				"https?://[^ \"')]+",
				"www[.][^ .]+[.][^ \"')]+",
			},
			scope_lines = 0,
			action = wezterm.action_callback(function(window, pane)
				local url = window:get_selection_text_for_pane(pane)
				if not url:find("http", 1) then
					url = "https://" .. url
				end
				wezterm.log_info("opening: " .. url)
				wezterm.open_with(url)
			end),
		}),
	},
	{
		key = "g",
		mods = "ALT",
		action = wezterm.action.QuickSelectArgs({
			label = "open repo in browser",
			patterns = {
				"github.com/[^ \"')]*",
				"[^ .\"'/$]+/[^ \"')/]+",
			},
			scope_lines = 0,
			action = wezterm.action_callback(function(window, pane)
				local url = window:get_selection_text_for_pane(pane)
				if not url:find("github.com/", 1) then
					url = "github.com/" .. url
				end
				url = "https://" .. url
				wezterm.log_info("opening: " .. url)
				wezterm.open_with(url)
			end),
		}),
	},
}

config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- link without https prefix
table.insert(config.hyperlink_rules, {
	regex = "www[.][^ .]+[.][^ \"')]+",
	format = "https://$0",
})

-- github links
table.insert(config.hyperlink_rules, {
	regex = "github.com[^ \"')]*",
	format = "https://$0",
})

-- github repos
-- TODO:
-- ignore if traling /
-- disallow more symbols: [] + * , : =
table.insert(config.hyperlink_rules, {
	-- regex = "[^ .\"'/$]+/[^ \"'/]+",
	-- regex = "[\\w]+/[\\w.]+",
	-- format = "https://github.com/$0",
	regex = "[\"']([\\w-]+/[\\w.-]+)[\"')]",
	format = "https://github.com/$1",
})

-- config.disable_default_mouse_bindings = true
-- config.mouse_bindings = {
-- 	{
-- 		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
-- 		action = wezterm.action.Nop,
-- 	},
-- 	{
-- 		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
-- 		action = wezterm.action.Nop,
-- 	},
-- }
-- TODO: disable horizontal scrolling

return config
