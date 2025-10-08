return {
  {
    'ibhagwan/fzf-lua',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    config = function()
      require('fzf-lua').setup({
        winopts = {
          height = 0.80,
          width = 0.80,
          row = 0.5,
          backdrop = 60,
        },
      })
      local fzf = require('fzf-lua')
      vim.keymap.set('n', '<leader>sh', fzf.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', fzf.live_grep_native, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sl', function()
        fzf.grep({ resume = true })
      end, { desc = '[S]earch by [L]ast' })
      vim.keymap.set('n', '<leader>sd', fzf.lsp_document_diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>so', function()
        fzf.oldfiles({
          cwd_only = true,
        })
      end, { desc = '[S]earch [O]ld Files' })
      vim.keymap.set('n', '<leader>s/', fzf.buffers, { desc = '[S]earch [/] in Open Files' })
      vim.keymap.set('n', '<leader>sn', function()
        fzf.files({ cwd = vim.fn.stdpath('config') })
      end, { desc = '[S]earch [N]eovim files' })
      vim.keymap.set('n', '<leader>/', fzf.grep_curbuf, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
