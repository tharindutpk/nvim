return {
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require('alpha')
      local startify = require('alpha.themes.startify')

      local ascii_header = [[
            ,
            |`-.__
            / ' _/
           ****` 
          /    }
         /  \ /
     \ /`   \\\
jgs   `\    /_\\
       `~~~~~``~`
    ]]

      local function center_header(header)
        local lines = {}
        for line in string.gmatch(header, '[^\n]+') do
          table.insert(lines, line)
        end

        local width = vim.api.nvim_win_get_width(0) -- Get the width of the current window
        local padding = math.floor((width - #lines[1]) / 100) -- Calculate padding based on the first line length
        for i, line in ipairs(lines) do
          lines[i] = string.rep(' ', padding) .. line
        end
        return lines
      end

      local custom_header = center_header(ascii_header)

      startify.section.header.val = custom_header

      -- add margins to the top and left
      startify.opts.layout[1].val = 5
      startify.opts.opts.margin = 60

      -- disable MRU
      startify.section.mru.val = {}

      -- Set menu
      startify.section.top_buttons.val = {
        startify.button('e', ' > New file', '<cmd>ene<CR>'),
        startify.button('o', ' > Recently opened', '<cmd>FzfLua oldfiles<CR>'),
        startify.button('f', ' > Find file', '<cmd>FzfLua files<CR>'),
        startify.button('g', ' > Find word', '<cmd>FzfLua live_grep_native<CR>'),
        startify.button('s', ' > Restore session', [[<cmd> lua require("persistence").load() <cr>]]),
        startify.button('l', ' > Open lazy', '<cmd> Lazy <cr>'),
      }

      -- Send config to alpha
      alpha.setup(startify.config)

      -- Disable folding on alpha buffer
      vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
  },
}
