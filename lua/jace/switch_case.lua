--- Switch cases
local function switch_case()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    local word = vim.fn.expand('<cword>')
    local word_start = vim.fn.matchstrpos(vim.fn.getline('.'), '\\k*\\%' .. (col + 1) .. 'c\\k*')[2]

    local new_word = ""

    -- Detect camelCase
    if word:find('[a-z][A-Z]') then
        -- Convert camelCase to snake_case
        local snake_case_word = word:gsub('([a-z])([A-Z])', '%1_%2'):lower()
        new_word = snake_case_word
        -- Detect snake_case
    elseif word:find('_[a-z]') then
        -- Convert snake_case to camelCase
        local camel_case_word = word:gsub('(_)([a-z])', function(_, l) return l:upper() end)
        new_word = camel_case_word
    else
        print("Not a snake_case or camelCase word")
    end

    local client_attached = false
    for client, _ in pairs(vim.lsp.get_clients()) do
        if vim.lsp.buf_is_attached(0, client) then
            client_attached = true
        end
    end

    local function non_lsp_change()
        local action = vim.fn.input("Change all (y|n|c)? ")
        if action == "y" then
            vim.cmd("%s/\\<" .. word .. "\\>/" .. new_word .. "/gc")
            vim.api.nvim_win_set_cursor(0, {line, col});
        elseif action == "n" then
            vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { new_word })
        end
    end

    if client_attached then
        vim.lsp.buf_request(0,
            'textDocument/documentHighlight',
            vim.lsp.util.make_position_params(),
            function(err, result, _, _)
                local is_lsp_word = false
                if not err and result and #result > 1 then
                    is_lsp_word = true
                end
                -- replace
                if is_lsp_word then
                    vim.lsp.buf.rename(new_word)
                else
                    non_lsp_change()
                end
            end)
    else
        non_lsp_change()
    end
end

vim.keymap.set("n", "<leader>sc", switch_case);
