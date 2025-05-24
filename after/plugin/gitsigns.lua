require('gitsigns').setup{
    on_attach = function(bufnr)
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        map('n', '<leader>hp', "<cmd>Gitsigns preview_hunk<CR>")
        map('n', '<leader>hn', "<cmd>Gitsigns next_hunk<CR>")
        map('n', '<leader>hr', "<cmd>Gitsigns reset_hunk<CR>")
    end
}
