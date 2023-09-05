local wezterm = require 'wezterm'

math.randomseed(os.time())

bg_img_num = math.random(1, 11)

M = {
--    default_prog = { 'wsl' },
    font = wezterm.font 'FiraCode Nerd Font Mono',
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
                File = (wezterm.home_dir .. "/.config/wezterm/bgcolor.png")
            }, 
            opacity = 1,
        },
        { 
            source = {
                File = (wezterm.home_dir .. "/.config/wezterm/wezbgs/" .. bg_img_num .. ".png")
            },
            opacity = 0.33,
            hsb = {
                brightness = 0.1
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
            key = 'h',
            mods = 'SHIFT|CTRL',
            action = wezterm.action.ToggleFullScreen,
        },
    },
    show_update_window = true,
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
if (exists("/System/Library/")) then
    M.font_size = 14.0
    M.term = "screen-256color"
end

--Windows
if (exists("C:\\Windows")) then
    M.default_prog = { 'pwsh-preview' }
end

return M 
