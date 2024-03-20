-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.maplocalleader = ' '
vim.g.mapleader = ','

vim.opt.undofile = false
vim.opt.inccommand = 'split'
-- vim.opt.iskeyword:append '-'
vim.opt.iskeyword:remove '_'
vim.opt.wrap = false
vim.opt.scrolloff = 10
