vim.g.vimspector_enable_mappings = "HUMAN"

vim.keymap.set("n", "<leader>di", "<cmd>VimspectorBalloonEval<CR>")
vim.keymap.set("x", "<leader>di", "<cmd>VimspectorBalloonEval<CR>")

vim.keymap.set("n", "<F5>", "<cmd>silent call vimspector#Continue()<CR>") --                           | When debugging, continue. Otherwise start debugging.
vim.keymap.set("n", "<F3>", "<cmd>silent call vimspector#Stop()<CR>") --                               | Stop debugging.
vim.keymap.set("n", "<F4>", "<cmd>silent call vimspector#Restart()<CR>") --                            | Restart debugging with the same configuration.
vim.keymap.set("n", "<F6>", "<cmd>silent call vimspector#Pause()<CR>") --                              | Pause debuggee.
vim.keymap.set("n", "<F9>", "<cmd>silent call vimspector#ToggleBreakpoint()<CR>") --                   | Toggle line breakpoint on the current line.
vim.keymap.set("n", "<leader><F9>", "<cmd>silent call vimspector#ToggleConditionalBreakpoint()<CR>") --| Toggle conditional line breakpoint or logpoint on the current line.
vim.keymap.set("n", "<F8>",  "<cmd>silent call vimspectorAddFunctionBreakpoint()<CR>") --              | Add a function breakpoint for the expression under cursor
vim.keymap.set("n", "<leader><F8>", "<cmd>silent call vimspector#RunToCursor()<CR>") --                | Run to Cursor
vim.keymap.set("n", "<F10>", "<cmd>silent call vimspector#StepOver()<CR>") --                          | Step Over
vim.keymap.set("n", "<leader><F11>", "<cmd>silent call vimspector#StepInto()<CR>") --                  | Step In
vim.keymap.set("n", "<F12>", "<cmd>silent call vimspector#StepOut()<CR>") --                   | Step out of current function scope

vim.keymap.set("n", "<leader>db", "<cmd>silent call vimspector#Launch()<CR>")
