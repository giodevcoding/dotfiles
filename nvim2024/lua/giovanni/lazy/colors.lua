function ColorMyPencils(color)
    vim.cmd.colorscheme(color)
end

function FullTransparent()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" }) vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
  --vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
  --vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
  --vim.api.nvim_set_hl(0, "SpecialKey", { bg = "none" })
  --vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
  --vim.api.nvim_set_hl(0, "NvimTree", { bg = "none" })
  --vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
  --vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
end

vim.api.nvim_set_hl(0, "folded", { fg = "grey" })

vim.api.nvim_create_autocmd("ColorScheme", { command = [[ execute "lua FullTransparent()"]] })
vim.keymap.set("n", "<leader>tc", function()
    local result = vim.treesitter.get_captures_at_cursor(0)
    print(vim.inspect(result))
end)

return {
    {
        'EdenEast/nightfox.nvim',
        lazy = false,
        priority = 1000,
    },
    {
        'eldritch-theme/eldritch.nvim',
        lazy = false,
        priority = 1000,
        config = function ()
            vim.cmd[[colorscheme eldritch]]
        end

    },
    {
        'embark-theme/vim',
        lazy = false,
        priority = 1000,

    },
}
