local dap = require('dap')

vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))")
vim.keymap.set("n", "<leader>B", function ()
    dap.set_breakpoint(vim.fn.input("Breakpoint Condtion: "))
end)
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, {})
vim.keymap.set("n", "<leader>ds", dap.continue, {})
vim.keymap.set("n", "<leader>di", dap.step_into, {})
vim.keymap.set("n", "<leader>do", dap.step_over, {})
vim.keymap.set("n", "<leader>dq", dap.step_out, {})
vim.keymap.set("n", "<leader>dr", dap.repl.open, {})
vim.keymap.set("n", "<leader>dl", dap.run_last, {})
vim.keymap.set("n", "<leader>dt", dap.terminate, {})

vim.keymap.set("n", "<leader>dd", ":lua require'dapui'.toggle()<CR>")

require("dapui").setup()

dap.defaults.fallback.integrated_terminal = {
    command = 'powershell.exe';
    args = {'-e'};
}

dap.defaults.fallback.internalConsole = {
    command = 'powershell.exe';
    args = {'-e'};
}

dap.adapters.python = {
    type = 'executable';
    command = 'python';
    args = {'-m', 'debugpy.adapter'};
}

dap.configurations.python = {
    {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        pythonPath = 'python';
        console = "integratedTerminal";
    }
}

dap.adapters.coreclr = {
    type = 'executable';
    command = 'C:/Users/jaces/netcoredbg/netcoredbg.exe';
    args = {'--interpreter=vscode'};
}

dap.configurations.cs = {
    {
        type = "coreclr";
        name = "launch - netcoredbg";
        request = "launch";
        program = function()
            --return vim.fn.input('Path to dll > ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
            return "C:/Users/jaces/OneDrive/Desktop/Uni/Projects/HelloWorld/bin/Debug/net7.0/HelloWorld.dll"
        end,
        console = "internalConsole";
    },
}
