local wezterm = require 'wezterm'

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
    }
}

function exists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
        if code == 13 then
            return true
        end
    end
    return ok, err
end

if (not exists("/opt/")) then
--    M.default_prog = { 'wsl' }
end

return M 
