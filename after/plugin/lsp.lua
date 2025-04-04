--vim.opt.signcolumn = 'yes'
local lsp = require("lsp-zero")
local lspconfig = require('lspconfig')

lsp.preset("recommended")

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<CR>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})
local on_attach = function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>pr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end

lsp.on_attach(on_attach)

local null_ls = require('null-ls')

null_ls.builtins.formatting.prettierd.with {
    disabled_filetypes = { "markdown" },
}

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.csharpier,
        --null_ls.builtins.diagnostics.cpplint.with(
        --    { args = { "--filter=-whitespace/braces,-legal/copyright,-readability/braces", "$FILENAME"}}
        --),
    };
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.format({ bufnr = bufnr })
                    --vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
})

lspconfig.rust_analyzer.setup({
    settings = {
        ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = {
                command = "clippy",
                allFeatures = true
            },
        },
    },
})

lspconfig.hls.setup({
    filetypes={'haskell', 'lhaskell', 'cabal'}
})

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = {"vim", "ui", "gc", "tasksuite"}
            }
        }
    }
})

lsp.setup()

local rust_tools = require('rust-tools')

rust_tools.setup({
    tools = {
        autoSetHints = true,
        inlay_hints = {
            show_parameter_hints = true
        },
    },
    server = {
        on_attach = on_attach,
        ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = {
                command = "clippy",
                allFeatures = true
            },
        },
    },
})

vim.diagnostic.config({
    virtual_text = true,
})

vim.lsp.set_log_level("off")

local function StartAvtLsp()
    local path = "/home/j.denny/avt/linter/avt_language_server.py"
    vim.lsp.start({
        name = 'avt-language-server',
        cmd = { "python", path},
        root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
    })
end

vim.api.nvim_create_user_command("StartAvtLsp", StartAvtLsp, {})

vim.api.nvim_create_autocmd({"BufNew"}, {
    pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
    callback = StartAvtLsp
})


--augroup AVTLanguageServer
--au!
--autocmd User lsp_setup call lsp#register_server({
--    \ 'name': 'hello-world-pygls-example',
--    \ 'cmd': {server_info->['python', 'path-to-hello-world-example/main.py']},
--    \ 'allowlist': ['*']
--    \ }})
--augroup END
