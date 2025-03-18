local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_mode
local fmt = require 'luasnip.extras.fmt'

ls.add_snippets('go', {
  s('pkg', fmt('package main\n\nfunc main() {\n\t{}\n}', i(0))),
  -- try adding multiple choice
  s('ife', fmt('if err != nil {\n\t{}\n}', i(0))),
  s('deb', fmt('fmt.Printf("{}: %+v\n", {}) // for debug', i(0), i(0))),
  s('wra', fmt('errors.Wrap(err, "{}")', i(0))),
  s('tes', fmt('func Test{}(t *testing.T) {\n\t{}\n}', i(0))),
})
