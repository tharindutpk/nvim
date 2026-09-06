vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require("util.lazy").later(function()
  require("gitsigns").setup({
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },

    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      -- navigation
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, "Jump to next git change")

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, "Jump to previous git change")

      -- staging (in gitsigns v1 `stage_hunk` toggles: run it on a staged hunk
      -- to unstage it, which is why there is no separate undo mapping)
      map("n", "<leader>hs", gitsigns.stage_hunk, "Git stage/unstage hunk")
      map("v", "<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Git stage/unstage hunk")

      map("n", "<leader>hr", gitsigns.reset_hunk, "Git reset hunk")
      map("v", "<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Git reset hunk")

      map("n", "<leader>hS", gitsigns.stage_buffer, "Git stage buffer")
      map("n", "<leader>hR", gitsigns.reset_buffer, "Git reset buffer")

      -- inspection
      map("n", "<leader>hp", gitsigns.preview_hunk, "Git preview hunk")
      map("n", "<leader>hi", gitsigns.preview_hunk_inline, "Git preview hunk inline")
      map("n", "<leader>hb", gitsigns.blame_line, "Git blame line")
      map("n", "<leader>hd", gitsigns.diffthis, "Git diff against index")
      map("n", "<leader>hD", function()
        gitsigns.diffthis("@")
      end, "Git diff against last commit")

      map("n", "<leader>tb", gitsigns.toggle_current_line_blame, "Toggle git blame line")
    end,
  })
end)
