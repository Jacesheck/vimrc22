local nnoremap = require("jace.keymap").nnoremap
local inoremap = require("jace.keymap").inoremap

nnoremap("<leader>pv", "<cmd>Ex<CR>")

nnoremap("<leader>ff", "<cmd>Telescope find_files hidden=true<cr>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep hidden=false<cr>")
nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")
nnoremap("<leader>gs", "<cmd>Telescope git_status<cr>")

nnoremap("<leader>tt", "<cmd>ToggleTerm<cr>")
nnoremap("<leader>1tt", "<cmd>1ToggleTerm<cr>")
nnoremap("<leader>2tt", "<cmd>2ToggleTerm<cr>")
nnoremap("<leader>3tt", "<cmd>3ToggleTerm<cr>")
nnoremap("<leader>4tt", "<cmd>4ToggleTerm<cr>")
nnoremap("<leader>5tt", "<cmd>5ToggleTerm<cr>")

nnoremap("<F5>","<Cmd>lua require'dap'.continue()<CR>")
nnoremap("<leader>u","<Cmd>lua require'dap'.step_over()<CR>")
nnoremap("<leader>i","<Cmd>lua require'dap'.step_into()<CR>")
nnoremap("<leader>o","<Cmd>lua require'dap'.step_out()<CR>")
nnoremap("<Leader>b","<Cmd>lua require'dap'.toggle_breakpoint()<CR>")
nnoremap("<Leader>B","<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
nnoremap("<Leader>lp","<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
nnoremap("<Leader>dr","<Cmd>lua require'dap'.repl.open()<CR>")
nnoremap("<Leader>dl","<Cmd>lua require'dap'.run_last()<CR>")
nnoremap("<Leader>dt","<Cmd>lua require'dap'.terminate()<CR>")

inoremap("jk", "<Esc>")
