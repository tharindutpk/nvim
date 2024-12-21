return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      {
        'nvim-treesitter/nvim-treesitter-context',
        enabled = true,
        opts = {
          mode = 'cursor',
          max_lines = 1,
        },
      },
      {
        'windwp/nvim-ts-autotag',
        config = function()
          require('nvim-ts-autotag').setup({
            opts = {
              enable_close = true,
              enable_rename = true,
              enable_close_on_slash = true,
            },
          })
        end,
      },
    },
    opts = {
      ensure_installed = {
        'bash',
        'css',
        'go',
        'gomod',
        'gosum',
        'gowork',
        'html',
        'javascript',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'regex',
        'rust',
        'svelte',
        'templ',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'yaml',
      },
      auto_install = true,
      highlight = {
        enable = true,
        -- Disable slow treesitter highlight for large files
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['aso'] = '@assignment.outer',
            ['asi'] = '@assignment.inner',
            ['asl'] = '@assignment.lhs',
            ['asr'] = '@assignment.rhs',
            ['pro'] = '@parameter.outer',
            ['pri'] = '@parameter.inner',
            ['fno'] = '@function.outer',
            ['fni'] = '@function.inner',
            ['clo'] = '@class.outer',
            ['cli'] = '@class.inner',
            ['cdo'] = '@conditional.outer',
            ['cdi'] = '@conditional.inner',
            ['lpo'] = '@loop.outer',
            ['lpi'] = '@loop.inner',
            ['fco'] = '@call.outer',
            ['fci'] = '@call.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']f'] = '@call.outer',
            [']m'] = '@function.outer',
            [']c'] = '@class.outer',
            [']i'] = '@conditional.outer',
            [']l'] = '@loop.outer',
          },
          goto_next_end = {
            [']F'] = '@call.outer',
            [']M'] = '@function.outer',
            [']C'] = '@class.outer',
            [']I'] = '@conditional.outer',
            [']L'] = '@loop.outer',
          },
          goto_previous_start = {
            ['[f'] = '@call.outer',
            ['[m'] = '@function.outer',
            ['[c'] = '@class.outer',
            ['[i'] = '@conditional.outer',
            ['[l'] = '@loop.outer',
          },
          goto_previous_end = {
            ['[F'] = '@call.outer',
            ['[M'] = '@function.outer',
            ['[C'] = '@class.outer',
            ['[I'] = '@conditional.outer',
            ['[L'] = '@loop.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>pi'] = '@parameter.inner',
            ['<leader>fo'] = '@function.outer',
          },
          swap_previous = {
            ['<leader>ip'] = '@parameter.inner',
            ['<leader>of'] = '@function.outer',
          },
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
