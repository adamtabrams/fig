-- stylua: ignore
-- if true then return {} end

local yank_lines = function(data)
  -- stylua: ignore
  if data.action ~= "toggle" then return end
  local lines = vim.api.nvim_buf_get_lines(0, data.line_start - 1, data.line_end, false)
  vim.fn.setreg("+", lines)
end

return {
  {
    "echasnovski/mini.comment",
    opts = {
      hooks = { pre = yank_lines },
    },
  },
}
