-- vim.opt.signcolumn = 'yes'
local lsp = require("lsp-zero")
local lspconfig = require('lspconfig')

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

local on_attach = function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.jump({float=true, count=1}) end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.jump({float=true, count=-1}) end, opts)
  vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>pr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end


vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = on_attach,
})

local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({}),
})

lspconfig.clangd.setup({});

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

lspconfig.gleam.setup({
    cmd={ "gleam", "lsp" }
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
    local function file_exists(name)
        local f=io.open(name,"r")
        if f~=nil then io.close(f) return true else return false end
    end

    if not file_exists(path) then return end

    vim.lsp.start({
        name = 'avt-language-server',
        cmd = { "python", path },
        root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
    })
end

vim.api.nvim_create_user_command("StartAvtLsp", StartAvtLsp, {})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
    callback = StartAvtLsp
})
