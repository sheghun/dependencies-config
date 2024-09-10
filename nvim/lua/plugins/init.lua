return {
  -- {
  --   "stevearc/conform.nvim",
  --   event = "BufWritePre", -- uncomment for format on save
  --   config = function()
  --     require "configs.conform"
  --   end,
  -- },

  {
    "neovim/nvim-lspconfig",
    pin = true,
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "gopls",
        "golangci-lint",
        "json-lsp",
        "gomodifytags",
        "impl",
        "goimports_reviser",
        "golines",
        "gofumpt",
        "refactoring",
        "prettier",
        "eslint",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "go",
        "gosum",
        "gomod",
        "gowork",
      },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    pin = true,
    event = "BufWritePre", -- uncomment for format on save
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      require "configs.null-ls"
    end,
  },
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {},
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "configs.gitsigns"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "git")
      require("gitsigns").setup(opts)
    end,
  },
  {
    "Wansmer/symbol-usage.nvim",
    event = "BufReadPre", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    config = function()
      require("symbol-usage").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup()
    end,
    event = "BufReadPost", -- This ensures the plugin loads after a buffer is read
  },
  {
    "mfussenegger/nvim-dap",
    event = "BufReadPost",
    dependencies = {
      "leoluz/nvim-dap-go", -- Specific for Go
      "rcarriga/nvim-dap-ui", -- Optional UI for DAP
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require "configs.nvim-dap"
    end,
  },
  {
    "sindrets/diffview.nvim", -- The plugin repository
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("diffview").setup {
        -- Add any specific configurations you want here
        enhanced_diff_hl = true, -- Example config: enhanced diff highlighting
      }
    end,
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" }, -- Load plugin when these commands are used
    module = "diffview", -- Load plugin when the diffview module is accessed
  },
}
