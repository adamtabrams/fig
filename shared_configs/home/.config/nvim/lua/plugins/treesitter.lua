-- if true then return {} end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-context' },
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
    },
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'json',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'regex',
        'vim',
        'vimdoc',
        'yaml',
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = false,
        keymaps = {
          init_selection = 'go',
          node_incremental = 'go',
          scope_incremental = 'gO',
          node_decremental = 'gi',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          include_surrounding_whitespace = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@conditional.outer',
            ['ic'] = '@conditional.inner',
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']f'] = '@function.outer',
            [']c'] = '@conditional.outer',
            [']a'] = '@parameter.inner',
          },
          goto_next_end = {
            [']F'] = '@function.outer',
            [']C'] = '@conditional.outer',
          },
          goto_prev_start = {
            ['[f'] = '@function.outer',
            ['[c'] = '@conditional.outer',
            ['[a'] = '@parameter.inner',
          },
          goto_prev_end = {
            ['[F'] = '@function.outer',
            ['[C'] = '@conditional.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['gmfn'] = '@function.outer',
            ['gmcn'] = '@conditional.outer',
            ['gman'] = '@parameter.inner',
          },
          swap_previous = {
            ['gmfp'] = '@function.outer',
            ['gmcp'] = '@conditional.outer',
            ['gmap'] = '@parameter.inner',
          },
        },
      },
    },
    config = function(_, opts) require('nvim-treesitter.configs').setup(opts) end,
  },
}
