-- Autocommands. `:help lua-guide-autocommands`

---@param name string
---@return integer
local function augroup(name)
  return vim.api.nvim_create_augroup("tharindutpk_" .. name, { clear = true })
end

-- yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  desc = "Highlight on yank",
  callback = function()
    vim.hl.on_yank()
  end,
})

-- buffers
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_location"),
  desc = "Restore last cursor position",
  callback = function(event)
    local buf = event.buf
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)

    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  desc = "Reload buffers changed outside Nvim",
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- quit
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  desc = "Close throwaway buffers with q",
  pattern = {
    "checkhealth",
    "gitsigns-blame",
    "help",
    "man",
    "nvim-pack",
    "qf",
    "query",
    "startuptime",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false

    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})
