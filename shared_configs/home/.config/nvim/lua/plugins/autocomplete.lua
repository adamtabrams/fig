-- if true then return {} end

return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-path' },
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(), -- [n]ext item
          ['<C-p>'] = cmp.mapping.select_prev_item(), -- [p]revious item
          ['<C-y>'] = cmp.mapping.confirm { select = true }, -- [y]es for item
          ['<C-q>'] = cmp.mapping.abort(), -- [q]uit completion
          ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- [u]pward scroll docs
          ['<C-d>'] = cmp.mapping.scroll_docs(4), -- [d]ownward scroll docs
          ['<C-Space>'] = cmp.mapping.complete {}, -- manually trigger a completion
          ['<C-l>'] = cmp.mapping(function() -- move to right expansion location
            if luasnip.expand_or_locally_jumpable() then luasnip.expand_or_jump() end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function() -- move to left expansion location
            if luasnip.locally_jumpable(-1) then luasnip.jump(-1) end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },
}
