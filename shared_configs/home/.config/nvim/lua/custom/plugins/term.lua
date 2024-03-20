-- if true then return {} end

return {
  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    config = function()
      local toggle = require 'toggleterm'
      toggle.setup {
        direction = 'float',
        -- start_in_insert = true,
        -- persist_mode = false,
      }

      local term = require 'toggleterm.terminal'
      local lazygit = term.Terminal:new { cmd = 'lazygit', hidden = true }

      -- TODO: consider <leader> mappings
      -- TODO: use 'keys' field?
      vim.keymap.set('n', ',l', function() lazygit:toggle() end, { desc = '[L]azygit', silent = true })
      vim.keymap.set('n', ',L', '<cmd>TermExec cmd="lazygit -f %"<cr>', { desc = '[L]azygit History', silent = true })
      vim.keymap.set('n', ',t', '<cmd>ToggleTerm<cr>', { desc = '[T]erminal', silent = true })

      -- TODO: fix nested
      vim.keymap.set('n', ',f', '<cmd>TermExec cmd="lf"<cr>', { desc = '[F]iles', silent = true })
    end,
  },
}
