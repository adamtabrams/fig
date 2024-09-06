-- if true then return {} end

-- nvim-treesitter
-- nvim-lspconfig
-- mason.nvim
-- nvim-dap-go
-- neotest-go
-- conform.nvim
-- nvim-dap

GoAlternate = function(create_new)
  local fullname = vim.fn.expand '%'
  local is_test = fullname:find('_test.go', -8, true)
  if is_test then
    vim.cmd(':e ' .. fullname:sub(1, -9) .. '.go')
    return
  end

  local fullname_test = fullname:sub(1, -4) .. '_test.go'
  --- @diagnostic disable-next-line: param-type-mismatch
  if vim.fn.bufname(fullname_test) ~= '' then
    vim.cmd(':e ' .. fullname_test)
    return
  end

  local dirname = vim.fn.expand '%:p:h'
  local basename = vim.fn.expand '%:p:t'
  local found = require('plenary.scandir').scan_dir(dirname, {
    add_dirs = false,
    depth = 0,
    search_pattern = basename,
  })

  if next(found) ~= nil then
    vim.cmd(':e ' .. fullname_test)
    return
  end

  if create_new then
    vim.cmd ':exe "norm ggyy\\<c-o>"'
    vim.cmd(':e ' .. fullname_test)
    vim.cmd ':norm Pj'
    return
  end

  vim.print('test file not found: ' .. fullname_test)
end

vim.keymap.set('n', 'ga', function() GoAlternate() end, { desc = '[A]lt Go File' })
vim.keymap.set('n', 'gA', function() GoAlternate(true) end, { desc = '[A]lt Go New File' })

return {}
