function PurgeBuffer()
    -- Get a list of all buffer numbers
    local buffers = vim.tbl_map(function(b)
        return b.bufnr
    end, vim.fn.getbufinfo())

    -- Delete all unlisted buffers
    for _, b in ipairs(vim.fn.getbufinfo({ buflisted = false })) do
        if not vim.tbl_contains(buffers, b.bufnr) then
            vim.api.nvim_buf_delete(b.bufnr, { force = true })
        end
    end
end

vim.cmd('command! PurgeBuffers lua PurgeBuffer()')
