-- if true then return {} end

return {
  {
    'echasnovski/mini.nvim',
    config = function()
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

      require('mini.surround').setup {
        mappings = {
          add = 'gs',
          delete = 'ds',
          replace = 'cs',
          find = '',
          find_left = '',
          highlight = '',
          update_n_lines = '',
        },
      }

      vim.keymap.set('n', "g'", 'gsiw"', { desc = "[']Quote whole word", remap = true })
      vim.keymap.set('n', 'dsf', 'dt(ds(', { remap = true, desc = '[D]el [S]urround [F]unction' })

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

      require('mini.comment').setup {
        hooks = {
          pre = function(data)
            if data.action ~= 'toggle' then return end
            local lines = vim.api.nvim_buf_get_lines(0, data.line_start - 1, data.line_end, false)
            vim.fn.setreg('+', lines)
          end,
        },
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
