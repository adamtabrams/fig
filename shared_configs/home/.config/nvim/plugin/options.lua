vim.opt.clipboard = 'unnamedplus'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.hlsearch = false
vim.opt.inccommand = 'split'
vim.opt.scrolloff = 5

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- vim.opt.updatetime = 250
-- vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

vim.opt.iskeyword:append '$'
vim.opt.iskeyword:append '-'
-- vim.opt.iskeyword:remove '_'

-- vim.opt.undofile = true
-- vim.opt.signcolumn = 'yes'

vim.opt.shada = { "'10", '<0', 's10', 'h' }
vim.opt.swapfile = false
vim.opt.more = false
vim.opt.linebreak = true

-- vim.opt.formatoptions:remove 'o'
-- vim.opt.conceallevel = 0
