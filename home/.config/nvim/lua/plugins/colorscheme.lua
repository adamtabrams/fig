-- if true then return {} end

return {

  {
    'chriskempson/base16-vim',
    priority = 1000,
    init = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme 'base16-oceanicnext'
      -- vim.cmd.colorscheme 'base16-solarflare'
    end,
  },

  -- {
  --   'mhartington/oceanic-next',
  --   priority = 1000,
  --   init = function()
  --     vim.opt.termguicolors = true
  --     vim.cmd.colorscheme 'OceanicNext'
  --   end,
  -- },

  -- {
  --   'folke/tokyonight.nvim',
  --   priority = 1000,
  --   init = function()
  --     vim.cmd.colorscheme 'tokyonight-storm'
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },
}
