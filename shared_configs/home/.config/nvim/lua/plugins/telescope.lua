-- if true then return {} end

return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    branch = '0.1.x',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function() return vim.fn.executable 'make' == 1 end,
      },
      { 'nvim-tree/nvim-web-devicons' },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[K]eymaps' })
      vim.keymap.set('n', '<leader>sb', builtin.builtin, { desc = '[B]uiltins' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.oldfiles, { desc = '[R]ecent Files' })
      vim.keymap.set('n', '<leader>s.', builtin.resume, { desc = '[.]Repeat' })
      vim.keymap.set('n', '<leader>sw', builtin.live_grep, { desc = '[W]ord' })
      vim.keymap.set('n', '<leader>sW', builtin.grep_string, { desc = '[W]ord Current' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[F]iles' })
      vim.keymap.set('n', '<leader>sG', builtin.git_files, { desc = '[G]it Root' })
      vim.keymap.set(
        'n',
        '<leader>sg',
        function() builtin.git_files { use_git_root = false } end,
        { desc = '[G]it' }
      )

      vim.keymap.set(
        'n',
        '<leader>sc',
        function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end,
        { desc = '[C]onfig' }
      )

      vim.keymap.set(
        'n',
        '<leader>s/',
        function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end,
        { desc = '[/]Across Buffers' }
      )

      -- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ]Change Buffer' })

      -- Testing
      vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = '[ ]files' })
      vim.keymap.set('n', '<leader>t', builtin.builtin, { desc = '[T]elescope' })
      vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = '[H]elp' })
      -- Testing

      vim.keymap.set(
        'n',
        '<leader>/',
        function()
          builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end,
        { desc = '[/]Search Buffer' }
      )
    end,
  },
}
