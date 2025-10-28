local wezterm = require 'wezterm'

math.randomseed(os.time())

local bg_img_num = math.random(1, 6)

local use_changing_bg = false

local background_file = (wezterm.home_dir .. "/.config/wezterm/background.png")

if use_changing_bg then
    background_file = (wezterm.home_dir .. "/.config/wezterm/wezbgs/" .. bg_img_num .. ".png")
end


M = {
    --    default_prog = { 'wsl' },
    font = wezterm.font_with_fallback { 'Cascadia Code', 'FiraCode Nerd Font Mono' },
    font_size = 11.0,
    color_scheme = "Dracula+",
    colors = {
        background = '#0E1419',
        foreground = '#F8F8F2',
        cursor_bg = '#8BE9FD',
        cursor_fg = '#0E1419',
        selection_bg = '#44475A',
    },
    hide_tab_bar_if_only_one_tab = true,
    --bg
    background = {
        {
            source = {
                Color = '#324'
            },
            width = "100%",
            height = "100%",
            opacity = 1,
        },
        {
            source = {
                File = background_file
            },
            opacity = 0.5,
            hsb = {
                brightness = 0.05
            }
        },
    },
    keys = {
        {
            key = 'F11',
            mods = 'SHIFT|CTRL',
            action = wezterm.action.ToggleFullScreen,
        },
        {
            key = 'F',
            mods = 'SHIFT|CTRL',
            action = wezterm.action.ToggleFullScreen,
        },
    },
    show_update_window = true,
    window_decorations = "RESIZE"
}


local function exists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
        if code == 13 then
            return true
        end
    end
    return ok, err
end

-- Mac
M.font_size = 15.0

--Windows
if (exists("C:\\Windows")) then
    M.default_prog = { 'pwsh-preview' }
end

return M
