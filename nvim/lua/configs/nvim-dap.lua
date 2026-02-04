require("dapui").setup()
require("dap-go").setup()

-- Rust/CodeLLDB debugging setup
local dap = require("dap")

local function setup_codelldb()
  local ok, mason_registry = pcall(require, "mason-registry")
  if not ok then return end

  local has_pkg, codelldb = pcall(mason_registry.get_package, "codelldb")
  if not has_pkg then return end

  local has_path, extension_path = pcall(function()
    return codelldb:get_install_path() .. "/extension/"
  end)
  if not has_path then return end

  local codelldb_path = extension_path .. "adapter/codelldb"

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = codelldb_path,
      args = { "--port", "${port}" },
    },
  }

  dap.configurations.rust = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }
end

setup_codelldb()

require("dap-vscode-js").setup {
  debugger_path = "/Users/segunoladiran/.config/vscode-js-debug/",
  adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
}

for _, language in ipairs { "typescript", "javascript" } do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      -- processId = require("dap.utils").pick_process,
      port = function()
        return coroutine.create(function(dap_run_co)
          vim.ui.input({ prompt = "Port: " }, function(input)
            coroutine.resume(dap_run_co, tonumber(input))
          end)
        end)
      end,
      cwd = "${workspaceFolder}",
    },
  }
end

dap.listeners.after.event_initialized["dapui_config"] = function()
  require("dapui").open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  require("dapui").close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  require("dapui").close()
end

vim.api.nvim_set_var("dap_log_level", "DEBUG")
vim.api.nvim_set_var("dap_log", true)

vim.fn.sign_define("DapBreakpoint", { text = "⭕", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define(
  "DapBreakpointCondition",
  { text = "♦️", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
)
vim.fn.sign_define("DapBreakpointRejected", { text = "❌", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "", numhl = "" })

vim.api.nvim_set_keymap("n", "<F12>", '<Cmd>lua require"dap".step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>db",
  '<Cmd>lua require"dap".toggle_breakpoint()<CR>',
  { noremap = true, silent = true }
)
vim.keymap.set("n", "<leader>dc", require("dap").continue, { noremap = true, desc = "debug continue", silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>B', '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F6>", '<Cmd>lua require"dap".repl.open()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F9>", '<Cmd>lua require"dap".run_last()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>du", '<Cmd>lua require"dapui".toggle()<CR>', { noremap = true, silent = true })

-- Keybinding to hover and evaluate expression
vim.api.nvim_set_keymap(
  "n",
  "<leader>dh",
  '<cmd>lua require("dap.ui.widgets").hover()<CR>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>dt",
  '<cmd>lua require("dap-go").debug_test()<CR>',
  { noremap = true, desc = "debug test", silent = true }
)
-- Keybinding to open a sidebar with expression evaluation
vim.api.nvim_set_keymap(
  "n",
  "<leader>df",
  '<cmd>lua require("dap.ui.widgets").centered_float(require("dap.ui.widgets").frames)<CR>',
  { noremap = true, silent = true }
)
