-- if true then return {} end

-- TODO: copy/open link
-- https://github.com/$owner/$repo/blame/$branch/$file#L123
-- https://github.com/$owner/$repo/blob/$branch/$file#L123
-- https://github.com/$owner/$repo/blob/$branch/$path/$file#L123
-- https://github.com/$owner/$repo/tree/$branch/$path1/$path2

local get_base_url = function(remote_url)
  local parts = {}
  for part in remote_url:gmatch '([^/]+)' do
    table.insert(parts, part)
  end
  return 'https://' .. parts[2] .. '/' .. parts[3] .. '/' .. parts[4]:gsub('%.git$', '')
end

local get_file_url = function(branch, root_path)
  local relative_path = vim.fn.expand('%:p'):sub(root_path:len() + 1)
  return branch .. relative_path .. '#L' .. vim.fn.line '.'
end

GitLink = function(git_type, use_main)
  local Job = require 'plenary.job'

  local git_branch = Job:new { command = 'git', args = { 'branch', '--show-current' } }
  local git_remote = Job:new { command = 'git', args = { 'config', 'remote.origin.url' } }
  local git_root = Job:new { command = 'git', args = { 'rev-parse', '--show-toplevel' } }
  if use_main then
    git_branch.args = { 'branch', '--remotes', '--format', '%(symref:lstrip=-1)', '--list', '*/HEAD' }
  end

  git_branch:start()
  git_remote:start()
  git_root:start()
  Job.join(git_remote, git_branch, git_root)

  if git_remote.code + git_branch.code + git_root.code > 0 then
    vim.print 'git commands failed'
    return
  end

  local base_url = get_base_url(git_remote:result()[1])
  local file_url = get_file_url(git_branch:result()[1], git_root:result()[1])
  local url = base_url .. git_type .. file_url

  vim.fn.setreg('+', url)
  vim.print('copied url for: ' .. git_type .. file_url)
end

vim.keymap.set('n', 'ghb', function() GitLink '/blame/' end, { desc = '[B]lame' })
vim.keymap.set('n', 'ghl', function() GitLink '/blob/' end, { desc = '[L]ink' })
vim.keymap.set('n', 'ghm', function() GitLink('/blob/', true) end, { desc = '[M]ain' })
-- vim.keymap.set('n', 'gl', function() GitLink '/blob/' end, { desc = '[L]ink Git' })
-- vim.keymap.set('n', 'gb', function() GitLink '/blame/' end, { desc = '[B]lame Git' })

return {}
