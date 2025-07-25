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

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>w", "<C-w>")

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

local insert_uuid = function ()
    local handle = io.popen("uuidgen | tr 'A-Z' 'a-z'")
    if handle then
        local uuid = handle:read("*a"):gsub("%s+$", "")
        handle:close()
        vim.api.nvim_put({ uuid }, 'c', true, true)
    end
end

vim.keymap.set("n", "<leader>iu", insert_uuid, { desc = "Insert lowercase UUID", noremap = true, silent = true })
