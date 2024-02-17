-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Override some formatting
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  command = "set formatoptions-=o conceallevel=0",
})

-- Remove trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
  command = "%s:\\s\\+$::e",
})

-- Fix highlight group
-- vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
--   pattern = "go.*",
--   callback = function()
--     vim.api.nvim_set_hl(0, "@string.special.url", { link = "Constant" })
--   end,
-- })

-- Prevent opening directories
local quit_if_dir = function()
  if vim.fn.isdirectory(vim.fn.expand("%")) == 0 then
    return
  end

  local bufs = vim.fn.getbufinfo({ buflisted = true })
  if #bufs <= 1 then
    vim.fn.execute("q")
    return
  end

  local bufname = vim.fn.bufname()
  vim.fn.execute("bd! " .. bufname)
  print("deleted " .. bufname)
end

vim.api.nvim_create_autocmd("BufEnter", {
  callback = quit_if_dir,
})
