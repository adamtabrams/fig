-- TODO: Plugins
-- Hop
-- refine: flatnvim(unloaded bufs and paths)
-- refine: go.lua and  go-git.lua
-- neotest? neotest-go?
-- use lazyvim fileds: 'keys' 'branch' 'event'
-- colorscheme
-- LSPs
-- SchemaStore?
-- luaSnip? friendly-snippets?

-- [[ Globals ]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ','
-- TODO: consider double space

-- [[ Options ]]

vim.opt.clipboard = 'unnamedplus'
-- vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.inccommand = 'split'
vim.opt.scrolloff = 10
-- vim.opt.cursorline = true
-- vim.opt.undofile = true
-- vim.opt.signcolumn = 'yes'

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.iskeyword:append '-'
-- vim.opt.iskeyword:remove '_'

-- [[ Autocommands ]]

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

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Remove trailing whitespace',
  group = vim.api.nvim_create_augroup('remove-trailing', { clear = true }),
  callback = function() vim.fn.substitute('%', '\\s\\+$', '', 'e') end,
})

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

-- [[ Keymaps ]]

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = '[D]iagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = '[D]iagnostic' })
vim.keymap.set('n', '<leader>dm', vim.diagnostic.open_float, { desc = '[M]essage' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = '[L]ist' })

-- Substitute
vim.keymap.set('v', '<localleader>s', ':s//g<left><left>', { desc = '[S]ubstitute' })
vim.keymap.set('n', '<localleader>s', ':%s//g<left><left>', { desc = '[S]ubstitute' })
vim.keymap.set('n', '<localleader>S', ':%s/<c-r><c-w>//g<left><left>', { desc = '[S]ubstitute Current' })

-- Quick quote
vim.keymap.set('n', "g'", 'gsiW"', { desc = "[']Quote whole word", remap = true })

-- Terminal escape
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Splits
vim.keymap.set('n', '<c-h>', '<c-w>W', { desc = 'Next Window' })
vim.keymap.set('n', '<c-l>', '<c-w>w', { desc = 'Prev Window' })
-- vim.keymap.set('n', '<leader>wq', '<c-w>q', { desc = '[Q]uit' })
-- vim.keymap.set('n', '<leader>wo', '<c-w>o', { desc = '[O]nly' })
vim.keymap.set('n', 'go', '<c-w>o', { desc = '[O]nly Window' })

-- Buffers
vim.keymap.set('n', '<c-j>', '<cmd>bn<cr>', { silent = true })
vim.keymap.set('n', '<c-k>', '<cmd>bp<cr>', { silent = true })
vim.keymap.set('n', '<c-q>', '<cmd>bd<cr>', { desc = '[Q]uit' })

-- Better defaults
vim.keymap.set({ 'n', 'v' }, 'c', '"_c', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'C', '"_C', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'x', '"_x', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'X', '"_X', { silent = true })

-- Quick save and quit
vim.keymap.set('n', 'gw', '<cmd>w<cr>', { desc = '[W]rite' })
vim.keymap.set('n', 'gq', '<cmd>q<cr>', { desc = '[Q]uit' })

-- [[ Plugins ]]

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('which-key').setup()
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]iagnostic', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]indow', _ = 'which_key_ignore' },
      }
    end,
  },

  {
    'nvim-pack/nvim-spectre',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    opts = { open_cmd = 'noswapfile vnew' },
    keys = {
      { '<localleader>r', function() require('spectre').open() end, desc = '[R]eplace Everywhere' },
    },
  },

  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  {
    'Darazaki/indent-o-matic',
    event = 'VeryLazy',
  },

  -- { 'NMAC427/guess-indent.nvim' },
  -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  -- { 'numToStr/Comment.nvim', opts = {} }, -- "gc" to comment visual regions/lines

  -- {
  --   'lewis6991/gitsigns.nvim',
  --   event = 'VeryLazy',
  --   opts = {},
  -- },

  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',

  { import = 'plugins' },
}, {
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
        'netrwPlugin',
        -- 'matchparen',
      },
    },
  },
})
