local builtin = require('telescope.builtin')

SEARCH_TESTS = false

local test_patterns = {
    "!**/test_*.*",
    "!**/*doctest.*"
}

vim.keymap.set('n', '<leader>pf', function ()
    if SEARCH_TESTS then
        builtin.find_files()
    else
        builtin.find_files{ find_command = {
            "fd",
            "-E", test_patterns[1],
            "-E", test_patterns[2]
        }}
    end
end, {})
vim.keymap.set('n', '<leader>pg', function ()
    if SEARCH_TESTS then
        builtin.live_grep()
    else
        builtin.live_grep{ glob_pattern = test_patterns }
    end
end, {})
--vim.keymap.set('n', '<leader>pr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>pa', function()
    if SEARCH_TESTS then
        builtin.grep_string({ word_match = "-w" })
    else
        builtin.grep_string({
            word_match = "-w",
            additional_args = function ()
                local ret = {}
                for _,v in ipairs(test_patterns) do
                    table.insert(ret, "--glob=" .. v)
                end
                return ret
            end
        })
    end
end, {})
vim.keymap.set('n', '<C-p>f', builtin.git_files, {})

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    lsp_references = {
        fname_width = 60,
    }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
