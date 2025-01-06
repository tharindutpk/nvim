return {
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    opts = function()
      local startify = require('alpha.themes.startify')
      local header = {}
      local header_image = [[
     |\_/|
     | @ @   Woof! Who dares, wins 
     |   <>              _
     |  _/\------____ ((| |))
     |               `--' |
 ____|_       ___|   |___.'
/_/_____/____/_______| ]]

      for _, line in pairs(vim.fn.split(header_image, '\n')) do
        table.insert(header, '     ' .. line)
      end

      startify.section.header.val = header

      -- Add margins to the top and left
      startify.opts.layout[1].val = 8
      startify.opts.layout[7].val = 1
      startify.opts.opts.margin = 30

      -- Disable MRU (saves some miliseconds)
      startify.section.mru.val = {}
      startify.section.mru_cwd.val = {}
      startify.section.bottom_buttons.val = {}

      startify.section.top_buttons.val = {
        startify.button('e', ' > New file', '<cmd>ene<CR>'),
        startify.button('o', ' > Recently opened', '<cmd>FzfLua oldfiles<CR>'),
        startify.button('f', ' > Find file', '<cmd>FzfLua files<CR>'),
        startify.button('g', ' > Find word', '<cmd>FzfLua live_grep_native<CR>'),
        startify.button('s', ' > Restore session', [[<cmd> lua require("persistence").load() <cr>]]),
        startify.button('l', ' > Open lazy', '<cmd> Lazy <cr>'),
        startify.button('q', ' > Quit', '<cmd>:qa<CR>'),
      }

      for _, button in ipairs(startify.section.top_buttons.val) do
        button.opts.hl = 'AlphaButtons'
        button.opts.hl_shortcut = 'AlphaShortcut'
      end

      return startify
    end,

    config = function(_, startify)
      -- Close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          once = true,
          pattern = 'AlphaReady',
          callback = function()
            require('lazy').show()
          end,
        })
      end

      require('alpha').setup(startify.config)

      vim.api.nvim_create_autocmd('User', {
        once = true,
        pattern = 'LazyVimStarted',
        callback = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          startify.section.footer.val = {
            {
              type = 'text',
              val = function()
                return ' ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms'
              end,
              opts = { hl = 'AlphaFooter' },
            },
          }
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
