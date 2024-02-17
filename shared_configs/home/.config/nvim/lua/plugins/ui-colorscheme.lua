-- stylua: ignore
-- if true then return {} end

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  pattern = "go.*",
  callback = function()
    vim.api.nvim_set_hl(0, "@string.special.url", { link = "Constant" })
  end,
})

return {
  { "EdenEast/nightfox.nvim" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nightfox",
    },
  },

  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = {
  --     highlight = {
  --       enable = true,
  --       custom_captures = {
  --         ["string.special.url"] = { link = "Constant" },
  --         -- ["string.special.url.gomod"] = "Constant",
  --         -- ["string.special.url"] = "Comment",
  --       },
  --     },
  --   },
  -- },

  -- {
  --   "EdenEast/nightfox.nvim",
  --   opts = {
  --     groups = {
  --       all = {
  --         string.special.url = { link = "Comment" },
  --       },
  --     },
  --
  --     -- specs = {
  --     --   all = {
  --     --     syntax = {
  --     --       string = "red",
  --     --     },
  --     --   },
  --     -- },
  --   },
  -- },

  -- "nvim-treesitter/playground",
}
