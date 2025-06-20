-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "jsonls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    completeUnimported = true,
    usePlaceholders = true,
    analyses = {
      unreachable = true,
      unusedvariable = true,
    },
  },
}
lspconfig.jsonls.setup {
  on_attach = function(client, capabilities)
    capabilities.documentFormattingProvider = false
  end,
  on_init = on_init,
}

-- SQL Language Server
lspconfig.sqlls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "sql-language-server", "up", "--method", "stdio" },
  filetypes = { "sql", "mysql" },
}

lspconfig.prismals.setup {
  cmd = { "prisma-language-server", "--stdio" },
  filetypes = { "prisma" },
  root_dir = lspconfig.util.root_pattern "schema.prisma",
  settings = {
    prisma = {
      prismaFmtBinPath = "prisma", -- Ensure it's using the correct formatter
    },
  },
}

-- BasedPyright (Python LSP)
lspconfig.basedpyright.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_dir = lspconfig.util.find_git_ancestor,
  settings = {
    basedpyright = {
      typeCheckingMode = "standard",
      reportMissingImports = true,
    },
  },
}

-- lspconfig.golangci_lint_ls.setup {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
--   filetypes = { "go", "gomod" },
-- }
