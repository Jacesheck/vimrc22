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
    vim.opt.shell = "bash -l"
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    pattern = { '*.js', '*.ts', '*.jsx', '*.tsx' },
    callback = function()
        vim.opt.shiftwidth = 2
    end
})

-- Don't add newlines to ends of files
vim.opt.fixeol = false

-- Sign column
vim.opt.scl = "yes"

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
