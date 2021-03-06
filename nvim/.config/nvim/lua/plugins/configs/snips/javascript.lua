local ls = require "luasnip"

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local s = ls.snippet
local i = ls.insert_node

local M = {
   s("db", fmt('console.log("{}: ", {});', { rep(1), i(1) })),
   s("exe", fmt('export * from "./{}"', { i(1) })),
   s("imp", fmt('import {{ {} }} from "{}"', { i(2), i(1) })),
   s("dimp", fmt('import {} from "{}"', { i(2), i(1) })),
   s("cl", fmt("console.log({})", { i(1) })),
}

return M
