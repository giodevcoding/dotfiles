vim.opt.background = "dark"
vim.opt.termguicolors = true

vim.g.aurora_italic = 1
vim.g.aurora_transparent = true
vim.g.aurora_bold = 1
vim.g.aurora_darker = 1
vim.g.monochrome_italic_comments = true

colorscheme_possibilities = {
    'aurora',
    'aurora',
    'aurora',
    'everblush',
    'kuroi',
    'moonfly',
    'moonfly',
    'moonfly',
    'monochrome',
    'night-owl',
    'nord',
    'srcery',
    'torte',
}

local function random_colorscheme()
    math.randomseed(os.time())
    local random_index = math.random(#colorscheme_possibilities)
    return colorscheme_possibilities[random_index]
end

chosen_colorscheme = random_colorscheme()

vim.cmd[[syntax enable]]
vim.cmd("colorscheme " .. chosen_colorscheme)

function fullTransparent()
    vim.cmd[[hi Normal guibg=none ctermbg=none]]
    vim.cmd[[hi NormalNC guibg=none ctermbg=none]]
    vim.cmd[[hi LineNr guibg=none ctermbg=none]]
    vim.cmd[[hi Folded guibg=none ctermbg=none]]
    vim.cmd[[hi NonText guibg=none ctermbg=none]]
    vim.cmd[[hi SpecialKey guibg=none ctermbg=none]]
    vim.cmd[[hi VertSplit guibg=none ctermbg=none]]
    vim.cmd[[hi SignColumn guibg=none ctermbg=none]]
    vim.cmd[[hi EndOfBuffer guibg=none ctermbg=none]]
    vim.cmd[[hi Terminal guibg=none ctermbg=none]]
    vim.cmd[[hi NvimTree guibg=none ctermbg=none]]
    vim.cmd[[hi NvimTreeNormal guibg=none ctermbg=none]]
    vim.cmd[[hi TelescopeNormal guibg=none ctermbg=none]]
end

fullTransparent()

-- Create command to randomize colorscheme
vim.api.nvim_create_user_command(
    'RandomScheme',
    function(opts)
        random_index = math.random(#colorscheme_possibilities)
        random_colorscheme = colorscheme_possibilities[random_index] 

        chosen_colorscheme = random_colorscheme 
        vim.cmd("colorscheme " .. chosen_colorscheme)
        fullTransparent()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'FullTransparent',
    function(opts)
        fullTransparent()
    end,
    { nargs = 0 }
)
