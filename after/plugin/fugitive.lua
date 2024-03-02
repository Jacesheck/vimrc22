vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gb", function () vim.cmd.Git('branch') end)
vim.keymap.set("n", "<leader>gl", function () vim.cmd.Git('log --oneline --decorate=full') end)
vim.keymap.set("n", "<leader>gm", function () vim.cmd.Git('blame') end)
