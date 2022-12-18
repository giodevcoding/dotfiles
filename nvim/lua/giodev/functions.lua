local functions = {}


local function giodev_terminal_command()
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        local bufid = vim.api.nvim_win_get_buf(winid)
        local bufname = vim.api.nvim_buf_get_name(bufid)
        if string.find(bufname, "term:") then
            vim.api.nvim_set_current_win(winid)
            vim.cmd([[startinsert]])
            return
        end
    end
    
    vim.cmd([[wincmd s]])
    vim.cmd([[wincmd j]])
    vim.cmd([[res 12]])
    vim.cmd([[term]])
    vim.cmd([[startinsert]])
end

functions.term_command = giodev_terminal_command

return functions
