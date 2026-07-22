-- if true then return {} end

-- TODO: combine with lsp.lua
-- TODO: try event VeryLazy

vim.keymap.set(
  'n',
  '<leader>cf',
  function() require('conform').format { formatters = { 'shfmt' } } end,
  { desc = 'temp shfmt' }
)

return {
  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- TODO: re-enable sh formatting
        -- local disable_filetypes = { c = true, cpp = true }
        local disable_filetypes = { c = true, cpp = true, sh = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'goimports', 'gofumpt' },
        -- sh = { 'shfmt' },
      },
    },
  },
}
