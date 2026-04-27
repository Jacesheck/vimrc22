--Treesitter features for installed languages need to be enabled manually in a
--|FileType| autocommand or |ftplugin|, e.g. >lua
vim.api.nvim_create_autocmd('FileType', {
pattern = { '*' },
callback = function()
  -- syntax highlighting, provided by Neovim
  pcall(vim.treesitter.start)
  -- folds, provided by Neovim
  --vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  --vim.wo.foldmethod = 'expr'
  -- indentation, provided by nvim-treesitter
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end,
})

require('nvim-treesitter').install { 'python', 'cpp' }
