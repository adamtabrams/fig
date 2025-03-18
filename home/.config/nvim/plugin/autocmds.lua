vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight text on yank',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
  desc = 'Override undesireable formatting',
  group = vim.api.nvim_create_augroup('fix-formatting', { clear = true }),
  callback = function()
    vim.opt.formatoptions:remove 'o'
    vim.opt.conceallevel = 0
  end,
})

-- vim.api.nvim_create_autocmd('BufWritePre', {
--   desc = 'Remove trailing whitespace',
--   group = vim.api.nvim_create_augroup('remove-trailing', { clear = true }),
--   callback = function() vim.fn.substitute('%', '\\s\\+$', '', 'e') end,
-- })

vim.api.nvim_create_autocmd({ 'VimResized' }, {
  desc = 'Update splits if window is resized',
  group = vim.api.nvim_create_augroup('resize-splits', { clear = true }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd 'tabdo wincmd ='
    vim.cmd('tabnext ' .. current_tab)
  end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Open buffer to previous location',
  group = vim.api.nvim_create_augroup('previous-location', { clear = true }),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then return end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  desc = 'Handle opening a directory',
  group = vim.api.nvim_create_augroup('handle-dir', { clear = true }),
  callback = function()
    if vim.fn.isdirectory(vim.fn.expand '%') == 0 then return end
    vim.api.nvim_buf_delete(0, {})
    require('telescope.builtin').find_files()
  end,
})
