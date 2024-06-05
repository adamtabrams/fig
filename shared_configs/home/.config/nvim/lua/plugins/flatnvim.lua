-- if true then return {} end

-- TODO: enhance flatnvim
-- trim absolute file paths
-- open relative file paths in other dirs

local parent = vim.fn.environ()['NVIM']
if parent == nil then return {} end

local chan = vim.fn.sockconnect('pipe', parent, { rpc = true })
vim.rpcrequest(chan, 'nvim_cmd', vim.api.nvim_parse_cmd('let flatnvim_buf = bufnr()', {}), {})

-- vim.rpcrequest(
--   chan,
--   'nvim_exec_lua',
--   --- @diagnostic disable-next-line: param-type-mismatch
--   [[ for _, buf in pairs(vim.api.nvim_list_bufs()) do
--        if not vim.api.nvim_buf_is_loaded(buf) then vim.api.nvim_buf_delete(buf, {}) end
--      end ]],
--   {}
-- )

for i = 0, vim.fn.argc() - 1 do
  vim.rpcrequest(chan, 'nvim_cmd', vim.api.nvim_parse_cmd('e! ' .. vim.fn.argv(i), {}), {})
end

vim.rpcnotify(chan, 'nvim_cmd', vim.api.nvim_parse_cmd('exe flatnvim_buf . "bd!"', {}), {})
vim.fn.chanclose(chan)
vim.api.nvim_cmd(vim.api.nvim_parse_cmd('q', {}), {})

return {}
