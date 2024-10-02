require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>")
map("n", "<leader>gb", "<cmd>Telescope git_bcommits<CR>")
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>")
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>")
map("n", "<leader>lf", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Open Floating Diagnostic Window" })
map("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = "Show All Diagnostics in Location List" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- init.lua
