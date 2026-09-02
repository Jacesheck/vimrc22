require("conform").setup({
    formatters_by_ft = {
        typescript = { "prettierd" },
        javascript = { "prettierd" },
    },
    --format_on_save = {
    --    -- I recommend these options. See :help conform.format for details.
    --    lsp_format = "fallback",
    --    timeout_ms = 500,
    --},
    notify_on_error = true,
})
