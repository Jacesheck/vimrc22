vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
--vim.opt.ic = true
vim.opt.cindent = true
if vim.fn.has('win32') == 1 then
    vim.opt.shell = 'powershell.exe'
else
    vim.opt.shell = "bash"
end

vim.opt.winborder = "rounded"

vim.opt.path = "**"

--vim.g.netrw_liststyle = 3 -- Tree style

vim.opt.smartindent = true

vim.opt.wrap = false

vim.g.mapleader = " "

vim.opt.scrolloff = 8

vim.opt.hidden = true

--undotree
vim.opt.swapfile = false
vim.opt.backup = false
if vim.fn.has('win32') ~= 0 then
    vim.opt.undodir = os.getenv("UserProfile") .. "/.vim/undodir"
else
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
end
vim.opt.undofile = true

vim.cmd("set colorcolumn=80,120")
