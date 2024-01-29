vim.opt.nu = true
vim.opt.relativenumber = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.api.nvim_create_autocmd("FileType", { pattern = {"javascript", "javascriptreact", "json", "vue", "html", "typescriptreact", "typescript"}, command = [[ setlocal tabstop=2 softtabstop=2 shiftwidth=2 ]] })

vim.opt.autoindent = false;
vim.opt.smartindent = true
vim.opt.cindent = false;

vim.opt.wrap = false

vim.opt.undofile = true;
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.background = "dark"
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.foldlevel = 99
