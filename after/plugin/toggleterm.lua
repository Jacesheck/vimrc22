function _G.set_terminal_keymaps()
    local opts = {buffer = 0}
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local powershell_options = {
    shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
    shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
}

if vim.fn.has('win32') == 1 then
    for option, value in pairs(powershell_options) do
        vim.opt[option] = value
    end
end

require('toggleterm').setup{
    open_mapping = "<C-\\>",
    insert_mappings = true,
    terminal_mappings = true,
    start_in_insert = false,
    close_on_exit = false,
}

function START_REACT()
    local Terminal = require('toggleterm.terminal').Terminal
    local back = Terminal:new{
        dir = 'C:/Users/jaces/Desktop/Jarom/teacherbackend',
        cmd='npm run local',
        count = 2,
        close_on_exit = false,
    }
    local front = Terminal:new{
        dir = 'C:/Users/jaces/Desktop/Jarom/teacherfrontend',
        cmd='npm start',
        count = 3,
        close_on_exit = false,
    }
    local cypress = Terminal:new{
        dir = 'C:/Users/jaces/Desktop/Jarom/teacherfrontend',
        cmd='npx cypress open',
        count = 4,
        close_on_exit = false,
    }
    -- use :toggle() to show instead
    back:spawn()
    front:spawn()
    cypress:spawn()
    print('Starting react server..')
end

function START_MANAGE()
    local Terminal = require('toggleterm.terminal').Terminal
    local back = Terminal:new{
        dir = 'C:/Users/jaces/Desktop/Jarom/manageteacherbackend',
        cmd='npm run local',
        count = 2,
        close_on_exit = false,
    }
    local front = Terminal:new{
        dir = 'C:/Users/jaces/Desktop/Jarom/manageteacherfrontend',
        cmd='npm start',
        count = 3,
        close_on_exit = false,
    }
    -- use :toggle() to show instead
    back:spawn()
    front:spawn()
    print('Starting manage server..')
end

vim.keymap.set('n', '<leader>srs', '<cmd>lua START_REACT()<CR>', {silent=true})
vim.keymap.set('n', '<leader>srm', '<cmd>lua START_MANAGE()<CR>', {silent=true})
