vim.opt.background = "dark"
vim.opt.termguicolors = true

vim.g.aurora_italic = 1
vim.g.aurora_transparent = 1
vim.g.aurora_bold = 1
vim.g.aurora_darker = 1

vim.g.monochrome_italic_comments = true

colorscheme_possibilities = {
    'aurora',
    'default',
    'elflord',
    'everblush',
    'industry',
    'koehler',
    'kuroi',
    'moonfly',
    'murphy',
    'monochrome',
    'night-owl',
    'nord',
    'quiet',
    'slate',
    'srcery',
    'tokyonight-night',
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

-- Create command to randomize colorscheme
vim.api.nvim_create_user_command(
    'RandomScheme',
    function(opts)
        random_index = math.random(#colorscheme_possibilities)
        random_colorscheme = colorscheme_possibilities[random_index] 

        chosen_colorscheme = random_colorscheme 
        vim.cmd("colorscheme " .. chosen_colorscheme)
    end,
    { nargs = 0 }
)
