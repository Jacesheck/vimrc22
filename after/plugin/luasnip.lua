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

ls.cleanup()
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/LuaSnip/"})

ls.config.set_config({
    enable_autosnippets = true,
})

-- Namespace: (declaration)
-- Class: (field_declaration)
-- None: (function_definition | declaration)

function DoxygenSnippet()
    local cursor = vim.api.nvim_win_get_cursor(0)
    cursor[1] = cursor[1] + 2
    cursor[2] = cursor[2] + 2
    print("Check " .. cursor[1] .. " " .. cursor[2])
    local node = vim.treesitter.get_node({ pos = cursor });

    local function_types = {
        declaration = true,
        field_declaration = true,
        function_definition = true,
    }

    --if node:type() == "translation_unit" then
    --    print("Is translation_unit")
    --end

    while not function_types[node:type()] do
        -- Error likely means couldn't find parent
        node = node:parent();
    end
    print(node:start() .. " " .. node:type())

    -- Query to capture return type and params
    local query_str = [[
[
 (declaration type: (_) @ret
              declarator: ((function_declarator
                parameters: (parameter_list
                  (parameter_declaration
                    declarator: (_) @params))?)))
 (field_declaration type: (_) @ret
                    declarator: (function_declarator
                      parameters: (parameter_list
                        (parameter_declaration
                          declarator: (_) @params))?))
 (function_definition type: (_) @ret
                      declarator: (function_declarator
                        parameters: (parameter_list
                          (parameter_declaration
                            declarator: (_) @params))?))
]
    ]]

    local has_return = false
    local params = {}
    local query = vim.treesitter.query.parse("cpp", query_str)
    for id, n in query:iter_captures(node) do
        if query.captures[id] == "ret" then
            local ret_type = ts_utils.get_node_text(n, 0)[1]
            print("Return type " .. ret_type)
            if ret_type ~= "void" then
                has_return = true
            end
        elseif query.captures[id] == "params" then
            local param_name = ts_utils.get_node_text(n, 0)[1]
            table.insert(params, param_name)
        end
    end

    local i = ls.insert_node
    local sn = ls.snippet_node
    local fmta = require("luasnip.extras.fmt").fmta

    local insert_nodes = {}
    local num = 0
    local final_str = ""
    for _, param in ipairs(params) do
        num = num + 1
        final_str = final_str .. " *  @param " .. param .. " <>\n\t"
        table.insert(insert_nodes, i(num))
    end
    if has_return then
        num = num + 1
        final_str = final_str .. " *  @return <>\n\t"
        table.insert(insert_nodes, i(num))
    end

    return sn(nil, fmta(final_str, insert_nodes))
end

vim.keymap.set("n", "<leader>pi",
function()
    vim.cmd("so ~/.config/nvim/after/plugin/luasnip.lua")
    DoxygenSnippet()
end);


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
