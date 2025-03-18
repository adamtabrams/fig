vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({ import = 'plugins' }, {
  change_detection = { notify = false },
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

-- up to date with commit-sha: 93fde0556e82ead2a5392ccb678359fa59437b98
-- compare with nvim-lua/kickstart.nvim/compare/{commit-sha}...master
