-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = '[D]iagnostic' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = '[D]iagnostic' })
vim.keymap.set('n', '<leader>dm', vim.diagnostic.open_float, { desc = '[M]essage' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = '[L]ist' })

-- Substitute
vim.keymap.set('v', '<localleader>s', ':s,,g<left><left>', { desc = '[S]ubstitute' })
vim.keymap.set('n', '<localleader>s', ':%s,,g<left><left>', { desc = '[S]ubstitute' })
vim.keymap.set('n', '<localleader>S', ':%s,<c-r><c-w>,,g<left><left>', { desc = '[S]ubstitute Current' })

-- Terminal escape
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<c-q>', '<C-\\><C-n>', { desc = '[Q]uit Terminal Mode' })

-- Splits
-- TODO: use <c-h> and <c-l> somewhere?
vim.keymap.set('n', '<c-h>', '<c-w>W', { desc = 'Next Window' })
vim.keymap.set('n', '<c-l>', '<c-w>w', { desc = 'Prev Window' })
vim.keymap.set('n', 'go', '<c-w>o', { desc = '[O]nly Window' })
-- vim.keymap.set('n', 'gv', '<c-w>L', { desc = '[V]ertical' })
-- vim.keymap.set('c', 'help', 'vert help')
vim.keymap.set('c', 'vh ', 'vert help ')

-- Buffers
-- TODO: use <c-j> and <c-k> somewhere?
-- TODO: use <c-n> and <c-p> somewhere?
vim.keymap.set('n', '<c-n>', '<cmd>bn<cr>', { silent = true })
vim.keymap.set('n', '<c-p>', '<cmd>bp<cr>', { silent = true })

-- vim.keymap.set('n', '<c-q>', '<cmd>bd<cr>', { desc = '[Q]uit' })
vim.keymap.set('n', '<c-q>', '<cmd>bd!<cr>', { desc = '[Q]uit' })

-- Better defaults
vim.keymap.set({ 'n', 'v' }, 'c', '"_c', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'C', '"_C', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'x', '"_x', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'X', '"_X', { silent = true })

-- Quick save and quit
vim.keymap.set('n', 'gw', '<cmd>w<cr>', { desc = '[W]rite' })
vim.keymap.set('n', 'gq', '<cmd>q<cr>', { desc = '[Q]uit' })
