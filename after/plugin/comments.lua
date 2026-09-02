require('todo-comments').setup({
    keywords = {
        CLAUDE = {
            icon = "🤖",
            color = "claude",
            alt = { "AI", "LLM" },
        },
    },
    colors = {
        claude = { "#D97752" },
    },
})

-- todo-comments uses `hi def`, so :colorscheme wipes its groups; re-apply them
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        require("todo-comments.config").colors()
    end,
})

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
