local on_attach = function(_, bufnr)
    local opts = {buffer = 0, remap = false}

    vim.keymap.set("n", "K", function() vim.lsp.buf.hover{border='rounded'} end, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump{float=true, count=1} end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump{float=true, count=-1} end, opts)
end

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'lua_ls', 'clangd'},
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
    callback = on_attach
})

vim.diagnostic.config({
    virtual_text = true,
})

vim.lsp.config('lua_ls', {
    on_attach = function() print("lua_ls") on_attach() end,
    capabilities = lsp_capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = {'vim', 'gc', 'ui', 'tasksuite'},
            },
            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                }
            }
        }
    }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
    sources = cmp.config.sources({
        {name = 'nvim_lsp'},
        {name = 'luasnip'},
    }, {
        {name = 'buffer'},
    }),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({select = true}),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})

------------ AVT LSP ---------------

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
