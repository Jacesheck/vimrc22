local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local ls = require("luasnip")
local cmp = require("cmp")
local ts_utils = require("nvim-treesitter.ts_utils")

-- Expand or jump
vim.keymap.set({"i"}, "<c-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, {silent = true})

-- Jump back
vim.keymap.set({"i", "s"}, "<c-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, {silent = true})

-- Change choice
vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
            ls.change_choice(1)
	end
end, {silent = true})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/LuaSnip/"})

ls.config.set_config({
    enable_autosnippets = true,
})

-- TODO: Figure out how to get param names and possible return val
--       using treesitter
function DoxygenSnippet()
    local node = vim.treesitter.get_node();
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]

    --local func_node = nil
    --for child in node:iter_children() do
    --    local row, _, _ = child:start()
    --    func_node = child
    --    print(child:start() .. " " .. child:type())
    --    if row > cursor_line + 1 and
    --        (child:type() == "function_definition" or
    --        child:type() == "function_declarator") then
    --        break
    --    end
    --end

    local type_node = func_node:field("type")[1]
    local return_type_name = ts_utils.get_node_text(type_node, 0)[1]

    local sn = ls.snippet_node
    local i = ls.insert_node
    local fmta = require("luasnip.extras.fmt").fmta

    local params = ""
    local insert_nodes = {}
    local decl_node = func_node:field("declarator")[1]
    local params_node = decl_node:field("parameters")[1]
    local num = 0
    for param in params_node:iter_children() do
        local param_node = param:field("declarator")[1]
        local param_name = ts_utils.get_node_text(param_node, 0)[1]
        if param_name ~= nil then
            num = num + 1
            params = params .. " * param " .. param_name .. " <>\n"
            table.insert(insert_nodes, i(num))
        end
    end
    if return_type_name ~= "void" then
        num = num + 1
        params = params .. " * return <>\n"
        table.insert(insert_nodes, i(num))
    end
    return sn(nil, fmta(params, insert_nodes))
end

vim.keymap.set("n", "<leader>pi", DoxygenSnippet);


cmp.setup({

  -- ... Your other configuration ...

  mapping = {

    -- ... Your other mappings ...
    ["<Tab>"] = nil,
    ["<S-Tab>"] = nil

    --["<Tab>"] = cmp.mapping(function(fallback)
    --  if cmp.visible() then
    --    cmp.select_next_item()
    --  -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
    --  -- they way you will only jump inside the snippet region
    --  elseif luasnip.expand_or_jumpable() then
    --    luasnip.expand_or_jump()
    --  elseif has_words_before() then
    --    cmp.complete()
    --  else
    --    fallback()
    --  end
    --end, { "i", "s" }),

    --["<S-Tab>"] = cmp.mapping(function(fallback)
    --  if cmp.visible() then
    --    cmp.select_prev_item()
    --  elseif luasnip.jumpable(-1) then
    --    luasnip.jump(-1)
    --  else
    --    fallback()
    --  end
    --end, { "i", "s" }),

    -- ... Your other mappings ...
  },

  -- ... Your other configuration ...
})
