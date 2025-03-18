-- if true then return {} end

-- TODO: Custom Commands
-- operator-pending
-- improve colors?
-- HopYankWord -> use wezterm instead
-- HopYankLine -> use wezterm instead

local copy_lines = function()
  local hop = require 'hop'
  local direction = require('hop.hint').HintDirection
  local original = vim.api.nvim_win_get_cursor(0)
  hop.hint_lines {}
  local start = vim.api.nvim_win_get_cursor(0)[1]
  hop.hint_lines { direction = direction.AFTER_CURSOR }
  local stop = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_get_lines(0, start - 1, stop, false)
  vim.fn.setreg('+', lines)
  vim.api.nvim_win_set_cursor(0, original)
end

vim.keymap.set('n', '<leader>y', copy_lines, { desc = '[Y]ank Lines Hop' })

return {
  {
    'smoka7/hop.nvim',
    event = 'VeryLazy',
    config = function()
      require('hop').setup {
        keys = 'fjdkslavmeirucwo',
        yank_register = '+',
      }

      -- testing
      vim.keymap.set({ 'n', 'v' }, 'gl', '<cmd>HopLine<cr>', { desc = '[L]ine Any Hop' })
      -- vim.keymap.set('n', 'ga', '<cmd>HopWordMW<cr>', { desc = '[A]ny Window Hop' })
      -- vim.keymap.set('n', 'gy', '<cmd>HopLine<cr>yy<c-o>', { desc = '[Y]ank Line Hop' })
      -- vim.keymap.set('n', '<leader>yy', '<cmd>HopLine<cr>yy<c-o>', { desc = '[Y]ank Line Hop' })
      -- testing

      -- vim.keymap.set('n', '<leader>L', '<cmd>HopLine<cr>', { desc = '[L]ine Any Hop' })
      vim.keymap.set({ 'n', 'v' }, '<leader>l', '<cmd>HopLineStart<cr>', { desc = '[L]ine Hop' })
      vim.keymap.set({ 'n', 'v' }, '<leader>f', '<cmd>HopWordCurrentLine<cr>', { desc = '[F]ind Hop' })
      vim.keymap.set('n', '<leader>A', '<cmd>HopWordMW<cr>', { desc = '[A]ny Window Hop' })
      vim.keymap.set('n', '<leader>a', '<cmd>HopWord<cr>', { desc = '[A]ny Word Hop' })
      vim.keymap.set('n', '<leader>n', '<cmd>HopNodes<cr>', { desc = '[N]ode Hope' })
      -- vim.keymap.set('n', '<leader>y', '<cmd>HopYankChar1<cr>', { desc = '[Y]ank Hop' })
    end,
  },
}
