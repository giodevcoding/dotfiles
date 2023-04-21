local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ")});
end, {})
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})

local telescope = require("telescope")

telescope.setup({
    extensions = {
        file_browser = {
            hijack_netrw = true,
            mappings = {
            }
        }
    }
})

telescope.load_extension("file_browser")

vim.keymap.set("n", "<leader>pv", "<cmd>Telescope file_browser<CR>")

