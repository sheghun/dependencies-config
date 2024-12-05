local options = {
  signcolumn = true,
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
}


vim.api.nvim_set_keymap('n', '<leader> gh', '<cmd>Gitsigns next_hunk<CR>', { noremap = true, desc = 'Go to next git change', silent = true })

return options
