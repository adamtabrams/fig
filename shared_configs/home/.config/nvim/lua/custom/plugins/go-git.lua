-- if true then return {} end

-- TODO: git blame in gutter
-- TODO: copy link/goto line in GitHub
-- TODO: add better bindings?

return {
  {
    'f-person/git-blame.nvim',
    event = 'VeryLazy',
    opts = {
      enabled = false,
      date_format = '%Y %m %d',
      delay = 50,
      -- display_virtual_text = false,
    },
  },
}
