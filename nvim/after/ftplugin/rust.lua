-- Rust recommended settings
vim.g.rustfmt_autosave = 1
vim.g.rust_recommended_style = 1

-- Rust-specific keymaps using rustaceanvim
local bufnr = vim.api.nvim_get_current_buf()

-- Code actions (better than default LSP)
vim.keymap.set("n", "<leader>ca", function()
  vim.cmd.RustLsp("codeAction")
end, { silent = true, buffer = bufnr, desc = "Rust code action" })

-- Run debuggables
vim.keymap.set("n", "<leader>rd", function()
  vim.cmd.RustLsp("debuggables")
end, { silent = true, buffer = bufnr, desc = "Rust debuggables" })

-- Run runnables
vim.keymap.set("n", "<leader>rr", function()
  vim.cmd.RustLsp("runnables")
end, { silent = true, buffer = bufnr, desc = "Rust runnables" })

-- Run tests
vim.keymap.set("n", "<leader>rt", function()
  vim.cmd.RustLsp("testables")
end, { silent = true, buffer = bufnr, desc = "Rust testables" })

-- Expand macro
vim.keymap.set("n", "<leader>rm", function()
  vim.cmd.RustLsp("expandMacro")
end, { silent = true, buffer = bufnr, desc = "Expand macro" })

-- Explain error
vim.keymap.set("n", "<leader>re", function()
  vim.cmd.RustLsp("explainError")
end, { silent = true, buffer = bufnr, desc = "Explain error" })

-- Open Cargo.toml
vim.keymap.set("n", "<leader>rc", function()
  vim.cmd.RustLsp("openCargo")
end, { silent = true, buffer = bufnr, desc = "Open Cargo.toml" })

-- Hover actions (enhanced hover)
vim.keymap.set("n", "K", function()
  vim.cmd.RustLsp({ "hover", "actions" })
end, { silent = true, buffer = bufnr, desc = "Rust hover actions" })
