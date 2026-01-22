local null_ls = require "null-ls"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Custom clang-tidy source
local clang_tidy = {
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { "c", "cpp", "cxx", "cc" },
  generator = null_ls.generator {
    command = "clang-tidy",
    args = function(params)
      return {
        params.bufname,
        "--",
        "-std=c++20",
      }
    end,
    to_stdin = false,
    from_stderr = false, -- clang-tidy outputs to stdout
    format = "line",
    check_exit_code = function(code)
      return code <= 1 -- clang-tidy returns 0 for no issues, 1 for issues found
    end,
    on_output = function(params, done)
      local diagnostics = {}
      local output = params.output
      
      if not output then
        return done(diagnostics)
      end
      
      -- Parse clang-tidy output format: file:line:col: severity: message [check-name]
      -- Example: /path/to/file.cpp:10:5: warning: message [check-name]
      for _, line in ipairs(output) do
        -- More flexible pattern to handle various clang-tidy output formats
        local file, line_num, col, severity, rest = line:match("^([^:]+):(%d+):(%d+): (%w+): (.+)$")
        if file and line_num and col then
          -- Extract message (remove check name in brackets if present)
          local message = rest:match("^(.+) %[.+%]$") or rest
          local severity_map = {
            error = vim.diagnostic.severity.ERROR,
            warning = vim.diagnostic.severity.WARN,
            note = vim.diagnostic.severity.INFO,
            info = vim.diagnostic.severity.INFO,
          }
          
          table.insert(diagnostics, {
            row = tonumber(line_num) - 1, -- 0-indexed
            col = tonumber(col) - 1, -- 0-indexed
            end_row = tonumber(line_num) - 1,
            end_col = tonumber(col),
            message = message,
            severity = severity_map[severity:lower()] or vim.diagnostic.severity.WARN,
            source = "clang-tidy",
          })
        end
      end
      
      return done(diagnostics)
    end,
  },
}

local options = {
  timeout = 10000,
  sources = {
    null_ls.builtins.diagnostics.golangci_lint.with {
      extra_args = { "--fix=true" },
      diagnostics_postprocess = function(diagnostic)
        diagnostic.message = "[golangci:" .. (diagnostic.code or "lint") .. "] " .. diagnostic.message
        diagnostic.code = nil -- Clear code to avoid duplication
      end,
    },
    null_ls.builtins.code_actions.gomodifytags,
    null_ls.builtins.code_actions.impl,
    null_ls.builtins.formatting.goimports_reviser,
    null_ls.builtins.formatting.golines,
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.formatting.clang_format.with {
      extra_args = { "--style=file" }, -- Use .clang-format file
    },
    -- clang_tidy, -- Disabled: clangd already provides clang-tidy with --clang-tidy flag
    -- cppcheck removed: use <leader>cc for project-wide analysis instead
    -- null_ls.builtins.formatting.prismaFmt.with {
    --   command = "npx", -- Use Prisma formatter from node_modules
    --   args = { "prisma", "format" },
    -- },
    null_ls.builtins.formatting.black, -- python formatter
    null_ls.builtins.formatting.forge_fmt, -- solidity formatter (requires Foundry)
    require "none-ls.diagnostics.ruff", -- python linter
    -- require "none-ls.code_actions.ruff", -- python code actions
    require "none-ls.code_actions.eslint",
    require "none-ls.diagnostics.eslint",
    -- require "none-ls.formatting.eslint",
  },

  -- on_attach = function(client, bufnr)
  --   if client.supports_method "textDocument/formatting" then
  --     vim.api.nvim_clear_autocmds {
  --       group = augroup,
  --       buffer = bufnr,
  --     }
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       group = augroup,
  --       buffer = bufnr,
  --       callback = function()
  --         vim.lsp.buf.format { bufnr = bufnr }
  --       end,
  --     })
  --   end
  -- end,
}

null_ls.setup(options)
