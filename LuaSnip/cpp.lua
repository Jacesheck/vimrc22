local ls = require("luasnip")

return {
    s({ trig = "//d"},
        fmta(
            [[
               /** @brief <>
                <>
                */
            ]],
            {
                i(0),
                d(1, DoxygenSnippet),
            }
        )
    ),
}
