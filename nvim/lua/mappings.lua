require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>")
map("n", "<leader>gb", "<cmd>Telescope git_bcommits<CR>")
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>")
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>")
map("n", "<leader>lf", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Open Floating Diagnostic Window" })
map("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = "Show All Diagnostics in Location List" })
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "LSP Code Action" })

-- Run cppcheck on whole project, results go to quickfix list
map("n", "<leader>cc", function()
  local cwd = vim.fn.getcwd()
  local compile_db = vim.fn.findfile("compile_commands.json", cwd .. ";")

  vim.cmd("cexpr []")

  local cmd
  if compile_db ~= "" then
    local project_dir = vim.fn.fnamemodify(compile_db, ":p:h")
    cmd = "cppcheck --enable=all --std=c++20 --language=c++ --project=" .. vim.fn.fnamemodify(compile_db, ":p") .. " 2>&1"
  else
    -- No compile_commands.json, just scan current directory
    vim.notify("No compile_commands.json found, scanning " .. cwd, vim.log.levels.WARN)
    cmd = "cppcheck --enable=all --std=c++20 --language=c++ --suppress=missingIncludeSystem " .. cwd .. " 2>&1"
  end

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.fn.setqflist({}, 'a', { lines = data })
      end
    end,
    on_exit = function()
      vim.cmd("copen")
    end,
  })
end, { desc = "Run cppcheck on project" })
map("n", "<leader>fr", function()
  vim.ui.input({ prompt = "Enter directory path: " }, function(input)
    require("telescope.builtin").live_grep { search_dirs = { input } }
  end)
end, { desc = "Search in Directory" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- init.lua
