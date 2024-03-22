-- if true then return {} end

-- nvim-treesitter
-- nvim-lspconfig
-- mason.nvim
-- nvim-dap-go
-- neotest-go
-- conform.nvim
-- nvim-dap

GoAlternate = function(create_new)
  local name = vim.fn.expand '%'
  local is_test = name:find('_test.go', -8, true)
  if is_test then
    vim.cmd(':e ' .. name:sub(1, -9) .. '.go')
    return
  end

  local test_name = name:sub(1, -4) .. '_test.go'
  --- @diagnostic disable-next-line: param-type-mismatch
  if vim.fn.bufname(test_name) ~= '' then
    vim.cmd(':e ' .. test_name)
    return
  end

  local dir = vim.fn.expand '%:p:h'
  local scan = require 'plenary.scandir'
  local found = scan.scan_dir(dir, { add_dirs = false, depth = 0, search_pattern = test_name })

  if next(found) ~= nil then
    vim.cmd(':e ' .. test_name)
    return
  end

  if create_new then
    vim.cmd ':exe "norm ggyy\\<c-o>"'
    vim.cmd(':e ' .. test_name)
    vim.cmd ':norm Pj'
    return
  end

  vim.print 'test file not found'
end

vim.keymap.set('n', 'ga', function() GoAlternate() end, { desc = '[A]lt Go File' })
vim.keymap.set('n', 'gA', function() GoAlternate(true) end, { desc = '[A]lt Go New File' })

return {}
