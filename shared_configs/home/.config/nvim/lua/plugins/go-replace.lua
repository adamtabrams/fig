-- if true then return {} end

-- Go Replace

-- TODO: handle text via paste mode

vim.keymap.set('n', 'gr', "<cmd>lua setopfn('v:lua.go_replace')<cr>g@", { desc = '[R]eplace' })
vim.keymap.set('n', 'gR', "<cmd>lua setopfn('v:lua.go_replace')<cr>g@$", { desc = '[R]eplace End' })
vim.keymap.set('n', 'grr', "<cmd>lua setopfn('v:lua.go_replace')<cr>g@V$", { desc = '[R]eplace Line' })

_G.setopfn = function(funcname) vim.go.operatorfunc = funcname end

_G.go_replace = function(mtype)
  local text = {}
  for line in vim.fn.getreg('+'):gmatch '([^\n]+)' do
    table.insert(text, line)
  end

  local start = vim.api.nvim_buf_get_mark(0, '[')
  local finish = vim.api.nvim_buf_get_mark(0, ']')

  if mtype == 'line' then
    vim.api.nvim_buf_set_lines(0, start[1] - 1, finish[1], false, text)
  elseif mtype == 'char' then
    vim.api.nvim_buf_set_text(0, start[1] - 1, start[2], finish[1] - 1, finish[2] + 1, text)
  end
end

-- Yank Append

-- TODO: concat based on mtype

vim.keymap.set('n', 'gy', "<cmd>lua setopfn('v:lua.append_yank')<cr>g@", { desc = '[Y]ank Append' })
vim.keymap.set('n', 'gY', "<cmd>lua setopfn('v:lua.append_yank')<cr>g@$", { desc = '[Y]ank Append End' })
vim.keymap.set('n', 'gyy', "<cmd>lua setopfn('v:lua.append_yank')<cr>g@V$", { desc = '[Y]ank Append Line' })

_G.append_yank = function(mtype)
  local start = vim.api.nvim_buf_get_mark(0, '[')
  local finish = vim.api.nvim_buf_get_mark(0, ']')

  local text
  if mtype == 'line' then
    text = vim.api.nvim_buf_get_lines(0, start[1] - 1, finish[1], false)
  elseif mtype == 'char' then
    text = vim.api.nvim_buf_get_text(0, start[1] - 1, start[2], finish[1] - 1, finish[2] + 1, {})
  end

  vim.fn.getreg '+'
  vim.fn.setreg('+', text, 'a')
end

return {}
