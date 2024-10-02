require("dapui").setup()
require("dap-go").setup()
local dap = require "dap"

dap.listeners.after.event_initialized["dapui_config"] = function()
  require("dapui").open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  require("dapui").close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  require("dapui").close()
end

vim.api.nvim_set_var('dap_log_level', 'DEBUG')
vim.api.nvim_set_var('dap_log', true)

vim.fn.sign_define('DapBreakpoint', {text='⭕', texthl='DapBreakpoint', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='♦️', texthl='DapBreakpointCondition', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='❌', texthl='DapBreakpointRejected', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='→', texthl='DapStopped', linehl='', numhl=''})


vim.api.nvim_set_keymap('n', '<F5>', '<Cmd>lua require"dap".continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F10>', '<Cmd>lua require"dap".step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F11>', '<Cmd>lua require"dap".step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>', '<Cmd>lua require"dap".step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>db', '<Cmd>lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>B', '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F6>', '<Cmd>lua require"dap".repl.open()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F9>', '<Cmd>lua require"dap".run_last()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>du', '<Cmd>lua require"dapui".toggle()<CR>', { noremap = true, silent = true })

-- Keybinding to hover and evaluate expression
vim.api.nvim_set_keymap('n', '<leader>dh', '<cmd>lua require("dap.ui.widgets").hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dt', '<cmd>lua require("dap-go").debug_test()<CR>', { noremap = true, silent = true })
-- Keybinding to open a sidebar with expression evaluation
vim.api.nvim_set_keymap('n', '<leader>df', '<cmd>lua require("dap.ui.widgets").centered_float(require("dap.ui.widgets").frames)<CR>', { noremap = true, silent = true })
