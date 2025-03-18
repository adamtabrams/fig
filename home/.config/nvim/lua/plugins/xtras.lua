-- TODO: simplify opts
-- TODO: fix whitespace trimming
-- TODO: improve status_line?
-- TODO: improve telescope performance (lazy load and fzf-native)
-- TODO: setup telescope multi-ripgrep
-- TODO: fix edit alternate for golang (see TJ's)
-- TODO: fix go.mod formatting

-- TODO: setup sindrets/diffview.nvim
-- TODO: setup snippets
-- TODO: setup debugloop/telescope-undo.nvim
-- TODO: norcalli/nvim-colorizer.lua for config files
-- TODO: spectre.nvim and oil.nvim?
-- TODO: checkout stevearc/qf_helper.nvim and kevinhwang91/nvim-bqf

-- TODO: improve zsh prompt -> "------\n(org/repo)  one/two/three\n"
-- TODO: checkout harpoon and wezterm sessionizer

-- neotest? neotest-go?
-- LSPs: shell
-- use lazyvim fileds: 'branch' 'event'
-- colorscheme
-- SchemaStore?
-- luaSnip? friendly-snippets?

return {

  -- {
  --   'folke/which-key.nvim',
  --   event = 'VeryLazy',
  --   config = function()
  --     require('which-key').setup {
  --       icons = {
  --         mappings = false,
  --       },
  --     }
  --     require('which-key').add {
  --       { '<leader>c', group = '[C]ode' },
  --       { '<leader>d', group = '[D]iagnostic' },
  --       { '<leader>s', group = '[S]earch' },
  --     }
  --   end,
  -- },

  -- {
  --   'nvim-pack/nvim-spectre',
  --   dependencies = {
  --     { 'nvim-lua/plenary.nvim' },
  --     { 'nvim-tree/nvim-web-devicons' },
  --   },
  --   opts = { open_cmd = 'noswapfile vnew' },
  --   keys = {
  --     { '<localleader>r', function() require('spectre').open() end, desc = '[R]eplace Everywhere' },
  --   },
  -- },

  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  -- {
  --   'Darazaki/indent-o-matic',
  --   event = 'VeryLazy',
  -- },

  -- { 'NMAC427/guess-indent.nvim' },
  -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  -- { 'numToStr/Comment.nvim', opts = {} }, -- "gc" to comment visual regions/lines

  -- {
  --   'lewis6991/gitsigns.nvim',
  --   event = 'VeryLazy',
  --   opts = {},
  -- },

  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
}
