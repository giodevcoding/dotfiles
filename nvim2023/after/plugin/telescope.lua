local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end, {})
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
vim.keymap.set('n', '<leader>pe', builtin.diagnostics, {})


local telescope = require("telescope")

telescope.setup({
    pickers = {
        buffers = {
            mappings = {
                n = {
                    ['d'] = require('telescope.actions').delete_buffer
                },
                i = {
                    ['<A-d>'] = require('telescope.actions').delete_buffer
                }
            }
        },
    },
    extensions = {
        file_browser = {
            hijack_netrw = true,
            hidden = {
                file_browser = true,
                folder_browser = true
            },
            mappings = {
            },
        }
    }
})

telescope.load_extension("file_browser")
telescope.load_extension("media_files")
telescope.load_extension("bibtex")
telescope.load_extension("dap")

vim.keymap.set("n", "<leader>pt", "<cmd>Telescope file_browser<CR>")
vim.keymap.set("n", "<leader>pv", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>")
