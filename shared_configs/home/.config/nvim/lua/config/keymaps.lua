-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Better Defaults
vim.keymap.set({ "n", "v" }, "c", '"_c', { silent = true })
vim.keymap.set({ "n", "v" }, "C", '"_C', { silent = true })
vim.keymap.set({ "n", "v" }, "x", '"_x', { silent = true })
vim.keymap.set({ "n", "v" }, "X", '"_X', { silent = true })

-- Save and Quit
vim.keymap.set("n", "gw", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set("n", "gq", "<cmd>q<cr>", { desc = "Quit" })

-- Set Local Leader
vim.g.maplocalleader = ";"

-- TODO:
-- improve leap config
-- goto file in github
-- golang fill struct
-- golang alternative file

-- Handle Windows
vim.keymap.set("n", "<localleader>w", "<c-w>W", { desc = "Window cycle", remap = true })
vim.keymap.set("n", "<localleader>q", "<c-w>q", { desc = "Window quit", remap = true })
vim.keymap.set("n", "<localleader>o", "<c-w>o", { desc = "Window only", remap = true })

-- Substitute
vim.keymap.set("v", "<localleader>s", ":s//g<left><left>", { desc = "Substitute begin" })
vim.keymap.set("n", "<localleader>s", ":%s//g<left><left>", { desc = "Substitute begin" })
vim.keymap.set("n", "<localleader>S", ":%s/<c-r><c-w>//g<left><left>", { desc = "Substitute word" })

-- Diagnostic
vim.keymap.set("n", "<localleader>n", vim.diagnostic.goto_next, { desc = "Diagnostic next" })
vim.keymap.set("n", "<localleader>N", vim.diagnostic.goto_prev, { desc = "Diagnostic previous" })

-- Telescope
vim.keymap.set("n", "<leader>sB", "<cmd>Telescope grep_string grep_open_files=true search=<cr>", { desc = "Grep bufs" })

-- Custom Actions
-- vim.keymap.set("n", "<localleader>'", 'ysiW"', { desc = "Quote whole word", remap = true })
vim.keymap.set("n", "<localleader><localleader>", 'ysiW"', { desc = "Quote whole word", remap = true })

vim.keymap.set("n", "<localleader>r", "<cmd>lua setopfn('v:lua.go_replace')<cr>g@", { desc = "Replace motion" })
vim.keymap.set("n", "<localleader>R", "<cmd>lua setopfn('v:lua.go_replace')<cr>g@$", { desc = "Replace end" })
vim.keymap.set("n", "<localleader>rr", "<cmd>lua setopfn('v:lua.go_replace')<cr>g@V$", { desc = "Replace line" })

vim.keymap.set("n", "<localleader>y", "<cmd>lua setopfn('v:lua.append_yank')<cr>g@", { desc = "Yank append motion" })
vim.keymap.set("n", "<localleader>Y", "<cmd>lua setopfn('v:lua.append_yank')<cr>g@$", { desc = "Yank append end" })
vim.keymap.set("n", "<localleader>yy", "<cmd>lua setopfn('v:lua.append_yank')<cr>g@V$", { desc = "Yank append line" })

-- LF
local Util = require("lazyvim.util")
local lfTermRoot = function()
  Util.terminal({ "lf" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false })
end
local lfTermCurrent = function()
  Util.terminal({ "lf" }, { esc_esc = false, ctrl_hjkl = false })
end

vim.keymap.set("n", "<localleader>l", lfTermRoot, { desc = "LF (root dir)" })
vim.keymap.set("n", "<localleader>L", lfTermCurrent, { desc = "LF (cwd)" })

-- Custom Functions
_G.setopfn = function(funcname)
  vim.go.operatorfunc = funcname
end

-- TODO put text in paste mode
_G.go_replace = function(mtype)
  local text = {}
  for line in vim.fn.getreg("+"):gmatch("([^\n]+)") do
    table.insert(text, line)
  end

  local start = vim.api.nvim_buf_get_mark(0, "[")
  local finish = vim.api.nvim_buf_get_mark(0, "]")

  if mtype == "line" then
    vim.api.nvim_buf_set_lines(0, start[1] - 1, finish[1], false, text)
  elseif mtype == "char" then
    vim.api.nvim_buf_set_text(0, start[1] - 1, start[2], finish[1] - 1, finish[2] + 1, text)
  end
end

_G.append_yank = function(mtype)
  local start = vim.api.nvim_buf_get_mark(0, "[")
  local finish = vim.api.nvim_buf_get_mark(0, "]")

  local text
  if mtype == "line" then
    text = vim.api.nvim_buf_get_lines(0, start[1] - 1, finish[1], false)
  elseif mtype == "char" then
    text = vim.api.nvim_buf_get_text(0, start[1] - 1, start[2], finish[1] - 1, finish[2] + 1, {})
  end

  vim.fn.getreg("+")
  vim.fn.setreg("+", text, "a")
end
