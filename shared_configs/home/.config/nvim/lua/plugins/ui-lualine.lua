-- stylua: ignore
-- if true then return {} end

local buffer_type = function()
  local symbols = {}

  if vim.bo.modified then
    table.insert(symbols, "[+]")
  end

  if vim.bo.modifiable == false or vim.bo.readonly == true then
    table.insert(symbols, "[-]")
  end

  if vim.fn.expand("%:t") == "" then
    table.insert(symbols, "[unnamed]")
  end

  local filename = vim.fn.expand("%")
  if filename ~= "" and vim.bo.buftype == "" and vim.fn.filereadable(filename) == 0 then
    table.insert(symbols, "[new]")
  end

  return table.concat(symbols, "")
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.sections.lualine_z = { buffer_type }
  end,
}
