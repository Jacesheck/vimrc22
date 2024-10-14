-- Hightlight trailing whitespace
vim.api.nvim_create_autocmd('BufEnter', {
    --TODO: Only do for writeable buffers
    callback = function()
        vim.cmd("highlight ExtraWhitespace ctermbg=red guibg=red")
        vim.cmd("match ExtraWhitespace /\\s\\+$/")
    end,
});
