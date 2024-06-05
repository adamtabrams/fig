vim.keymap.set('n', ',t', '<cmd>term<cr>', { desc = '[T]erminal', silent = true })
vim.keymap.set('n', ',l', '<cmd>term lf<cr>', { desc = '[L]F', silent = true })
vim.keymap.set('n', ',L', '<cmd>term lazygit<cr>', { desc = '[L]azygit', silent = true })
vim.keymap.set('n', ',h', '<cmd>term lazygit -f %<cr>', { desc = '[H]istory', silent = true })

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Configure window for builtin terminal',
  group = vim.api.nvim_create_augroup('term-open-config', { clear = true }),
  callback = function()
    vim.opt_local.laststatus = 0
    vim.opt_local.ruler = false
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd.startinsert()
  end,
})

vim.api.nvim_create_autocmd('TermClose', {
  desc = 'Close terminal window on exit code 0',
  group = vim.api.nvim_create_augroup('term-close-config', { clear = true }),
  callback = function()
    if vim.v.event.status == 0 then vim.api.nvim_buf_delete(0, {}) end
    vim.opt_local.laststatus = 2
    vim.opt_local.ruler = true
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
  end,
})

if true then return {} end

return {
  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    config = function()
      local toggle = require 'toggleterm'
      toggle.setup {
        direction = 'float',
        -- start_in_insert = true,
        persist_mode = false,
      }

      local term = require 'toggleterm.terminal'
      local lazygit = term.Terminal:new { cmd = 'lazygit', hidden = true }
      local lazyhist = term.Terminal:new { cmd = 'lazygit -f %', hidden = true }

      -- TODO: consider <leader> mappings
      -- TODO: use 'keys' field?
      vim.keymap.set('n', ',L', function() lazygit:toggle() end, { desc = '[L]azygit', silent = true })
      vim.keymap.set('n', ',h', function() lazyhist:toggle() end, { desc = '[L]azygit', silent = true })
      -- vim.keymap.set('n', ',L', '<cmd>TermExec cmd="lazygit -f %"<cr>', { desc = '[L]azygit History', silent = true })
      vim.keymap.set('n', ',t', '<cmd>ToggleTerm<cr>', { desc = '[T]erminal', silent = true })

      -- TODO: fix nested
      vim.keymap.set('n', ',l', '<cmd>TermExec cmd="lf"<cr>', { desc = '[F]iles', silent = true })
    end,
  },
}
