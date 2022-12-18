require("toggleterm").setup {
    size = 12,
    open_mapping = '<C-\\>/',
    winbar = {
        enabled = true
    }
}

local lazy = require("toggleterm.lazy")
local ui = lazy.require("toggleterm.ui")
local terms = require("toggleterm.terminal")

local function focusToggleTerm()
    if ui.find_open_windows() then
        terms.get_all()[1]:focus()
    else
        terms.get_or_create_term(1, nil, nil):open(12, nil)
    end
end

vim.api.nvim_create_user_command(
    'ToggleTermFocus',
    focusToggleTerm,
    { nargs = 0 }
)


