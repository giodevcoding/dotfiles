vim.g.mapleader = " ";

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dp")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>w", "<C-w>")

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Telekasten
vim.keymap.set("n", "<leader>z", "<cmd>Telekasten panel<CR>")

vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>")
vim.keymap.set("n", "<leader>zN", "<cmd>Telekasten new_templated_note<CR>")
vim.keymap.set("n", "<leader>zr", "<cmd>Telekasten rename_note<CR>")

vim.keymap.set("n", "<leader>za", "<cmd>Telekasten show_tags<CR>")
vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
vim.keymap.set("n", "<leader>zB", "<cmd>Telekasten find_friends<CR>")


vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>")
vim.keymap.set("n", "<leader>zD", "<cmd>Telekasten find_daily_notes<CR>")
vim.keymap.set("n", "<leader>zw", "<cmd>Telekasten goto_thisweek<CR>")
vim.keymap.set("n", "<leader>zW", "<cmd>Telekasten find_weekly_notes<CR>")

vim.keymap.set("n", "<leader>zi", "<cmd>Telekasten insert_link<CR>")
vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>")

vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>")
vim.keymap.set("n", "<leader>zy", "<cmd>Telekasten yank_notelink<CR>")
vim.keymap.set("n", "<leader>zt", "<cmd>Telekasten toggle_todo<CR>")
