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
    s({ trig = "sc"},
        fmta(
            [[
                SUBCASE("<>")
                {
                    <>
                }
            ]],
            { i(1), i(0) }
        )
    ),
    s({ trig = "tc"},
        fmta(
            [[
                TEST_CASE("<>")
                {
                    <>
                }
            ]],
            { i(1), i(0) }
        )
    ),
}
