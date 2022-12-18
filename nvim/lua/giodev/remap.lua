local nnoremap = require("giodev.keymap").nnoremap
local tnoremap = require("giodev.keymap").tnoremap
local inoremap = require("giodev.keymap").inoremap
local vnoremap = require("giodev.keymap").vnoremap
local xnoremap = require("giodev.keymap").xnoremap
local luamap = require("giodev.keymap").luamap

-- Stupid Touchbar on Mac
nnoremap("<C-`>", "<Esc>")
tnoremap("<C-`>", "<Esc>")
inoremap("<C-`>", "<Esc>")
vnoremap("<C-`>", "<Esc>")
xnoremap("<C-`>", "<Esc>")

-- NvimTree
nnoremap("<leader>nt", "<cmd>NvimTreeFocus<CR>")
nnoremap("<leader>nc", "<cmd>NvimTreeToggle<CR>")

-- Telescope
local builtin = require("telescope.builtin")
nnoremap("<leader>fs", builtin.find_files)
nnoremap("<leader>fg", builtin.live_grep)
nnoremap("<leader>fw", builtin.buffers)
nnoremap("<leader>fh", builtin.help_tags)

-- Telescope File Browser
nnoremap("<leader>fb", "<cmd>Telescope file_browser<CR>");
nnoremap("<leader>nf", "<cmd>Telescope file_browser<CR>");

-- Undotree
nnoremap("<leader>ut", "<cmd>UndotreeToggle<CR>")
nnoremap("<leader>uf", "<cmd>UndotreeFocus<CR>")

-- VIM WINDOWS 
nnoremap("<leader>w", "<C-w>")

-- ToggleTerm
--nnoremap("<leader>``", function() return "<cmd>ToggleTerm ".. vim.v.count .. "<CR>" end, {expr = true})
nnoremap("<leader>``", "<cmd>ToggleTermFocus<CR>")
nnoremap("<leader>`o", function() return "<cmd>ToggleTerm ".. vim.v.count .. " direction=horizontal size=12<CR>" end, {expr = true})
nnoremap("<leader>`h", function() return "<cmd>ToggleTerm ".. vim.v.count .. " direction=horizontal size=12<CR>" end, {expr = true})
nnoremap("<leader>`f", function() return "<cmd>ToggleTerm ".. vim.v.count .. " direction=float<CR>" end, {expr = true})
nnoremap("<leader>`v", function() return "<cmd>ToggleTerm ".. vim.v.count .. " direction=vertical size=60<CR>" end, {expr = true})
nnoremap("<leader>`c", "<cmd>ToggleTerm<CR>")
nnoremap("<leader>`q", "<cmd>bd!<CR>")
tnoremap("<C-q>", "<cmd>ToggleTerm<CR>")
tnoremap("<Esc>", "<C-\\><C-n>")

-- Prettier
nnoremap("<leader>pr", "<cmd>Prettier<CR>")

-- COQ
nnoremap("<leader>cq", "<cmd>COQnow --shut-up<CR>")

-- LSPSaga
nnoremap("<leader>lh", "<cmd>Lspsaga hover_doc<CR>", {silent = true})
nnoremap("<leader>lf", "<cmd>Lspsaga lsp_finder<CR>", {silent = true})
nnoremap("<leader>la", "<cmd>Lspsaga code_action<CR>", {silent = true})
nnoremap("<leader>lr", "<cmd>Lspsaga rename<CR>", {silent = true})
nnoremap("<leader>ld", "<cmd>Lspsaga peek_definition<CR>", {silent = true})
luamap("<leader>le", "vim.diagnostic.open_float()", {silent = true})

-- Barbar
nnoremap("<leader>bh", "<cmd>BufferPrevious<CR>")
nnoremap("<leader>bl", "<cmd>BufferNext<CR>")
nnoremap("<leader>b<", "<cmd>BufferMovePrevious<CR>")
nnoremap("<leader>b>", "<cmd>BufferMoveNext<CR>")

nnoremap("<leader>b1", "<cmd>BufferGoto 1<CR>")
nnoremap("<leader>b2", "<cmd>BufferGoto 2<CR>")
nnoremap("<leader>b3", "<cmd>BufferGoto 3<CR>")
nnoremap("<leader>b4", "<cmd>BufferGoto 4<CR>")
nnoremap("<leader>b5", "<cmd>BufferGoto 5<CR>")
nnoremap("<leader>b6", "<cmd>BufferGoto 6<CR>")
nnoremap("<leader>b7", "<cmd>BufferGoto 7<CR>")
nnoremap("<leader>b8", "<cmd>BufferGoto 8<CR>")
nnoremap("<leader>b9", "<cmd>BufferGoto 9<CR>")
nnoremap("<leader>b0", "<cmd>BufferLast<CR>")

nnoremap("<leader>bp", "<cmd>BufferPin<CR>")
nnoremap("<leader>bc", "<cmd>BufferClose<CR>")
nnoremap("<leader>bq!", "<cmd>BufferClose!<CR>")
nnoremap("<leader>bz", "<cmd>BufferCloseAllButCurrent<CR>")
nnoremap("<leader>b/", "<cmd>BufferPick<CR>")

nnoremap("<leader>bob", "<cmd>BufferOrderByBufferNumber<CR>")
nnoremap("<leader>bod", "<cmd>BufferOrderByDirectory<CR>")
nnoremap("<leader>bol", "<cmd>BufferOrderByLanguage<CR>")
nnoremap("<leader>bow", "<cmd>BufferOrderByWindowNumber<CR>")
