-- if true then return {} end

-- TODO: Custom Commands
-- HopYankWord
-- HopYankLine
-- HopYankLines
-- support insert mode
-- improve colors?

return {
  {
    'smoka7/hop.nvim',
    event = 'VeryLazy',
    config = function()
      require('hop').setup {
        keys = 'fjdkslavmeirucwo',
        yank_register = '+',
      }

      vim.keymap.set('n', '<leader>y', ':HopYankChar1<cr>', { desc = '[Y]ank Hop' })
      vim.keymap.set('n', '<leader>n', ':HopNodes<cr>', { desc = '[N]ode Hope' })
      vim.keymap.set('n', '<leader>l', ':HopLineStart<cr>', { desc = '[L]ine Hop' })
      vim.keymap.set('n', '<leader>f', ':HopWordCurrentLine<cr>', { desc = '[F]ind Hop' })
      vim.keymap.set('n', '<leader>a', ':HopWord<cr>', { desc = '[A]ny Word Hop' })
      vim.keymap.set('n', '<leader>A', ':HopWordMW<cr>', { desc = '[A]ny Window Hop' })
    end,
  },
}
