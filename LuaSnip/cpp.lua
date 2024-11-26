local ls = require("luasnip")

return {
    s({ trig = "//d"},
        fmta(
            "<>",
            {
                d(1, DoxygenSnippet),
            }
        )
    ),
}
