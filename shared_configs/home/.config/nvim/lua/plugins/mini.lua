-- if true then return {} end

return {
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      -- [Y]ank [I]nside [N]ext [)]paren
      -- [C]hange [I]nside [L]ast [)]paren
      require('mini.ai').setup {
        n_lines = 500,
        -- search_method = 'cover_or_next',
        mappings = {
          -- NOTE: review these bindings
          arount_next = 'an',
          inside_next = 'in',
          arount_last = 'aN',
          inside_last = 'iN',
        },
      }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      -- [Y]all? [S]urround [I]nner [W]ord [)]paren
      -- [D]elete [S]urround [)]paren
      -- [C]hange [S]urround [)]paren
      require('mini.surround').setup {
        mappings = {
          add = 'ys',
          delete = 'ds',
          replace = 'cs',
          find = '',
          find_left = '',
          highlight = '',
          update_n_lines = '',
        },
      }

      -- NOTE: review this keymap
      vim.keymap.set('n', 'dsf', "dt(mz%x'zx", {})

      local iscope = require 'mini.indentscope'
      iscope.setup {
        draw = {
          delay = 10,
          animation = iscope.gen_animation.none(),
        },
        options = {
          -- border = 'none',
          border = 'top',
          indent_at_cursor = false,
        },
        symbol = '│',
      }

      -- Comment and uncomment lines
      local yank_lines = function(data)
        if data.action ~= 'toggle' then return end
        local lines = vim.api.nvim_buf_get_lines(0, data.line_start - 1, data.line_end, false)
        vim.fn.setreg('+', lines)
      end

      require('mini.comment').setup {
        hooks = { pre = yank_lines },
      }

      -- Simple statusline
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = true }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      -- ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function() return '%2l:%-2v' end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
