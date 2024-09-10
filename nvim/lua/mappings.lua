require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map('n', '<leader>gc', '<cmd>Telescope git_commits<CR>')
map('n', '<leader>gb', '<cmd>Telescope git_bcommits<CR>')
map('n', '<leader>gs', '<cmd>Telescope git_status<CR>')
map('n', '<leader>gb', '<cmd>Telescope git_branches<CR>')
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
