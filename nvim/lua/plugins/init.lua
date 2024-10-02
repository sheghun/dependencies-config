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
    version = "v1.0.0",
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
        enhanced_diff_hl = true,
        view = {
          merge_tool = {
            disable_diagnostics = false,
          },
        },
        hooks = {
          view_opened = function()
            vim.cmd [[highlight DiffAdd guibg=#266b21 guifg=NONE]]
            vim.cmd [[highlight DiffChange guibg=#21476b guifg=NONE]]
            vim.cmd [[highlight DiffDelete guibg=#700202 guifg=NONE]]
            vim.cmd [[highlight DiffText guibg=#1a1078 guifg=NONE]]
          end,
        },
      }
    end,
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" }, -- Load plugin when these commands are used
    module = "diffview", -- Load plugin when the diffview module is accessed
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = "v0.0.2", -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
      provider = "openai",
      openai = {
        model = "gpt-4o",
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make BUILD_FROM_SOURCE=true",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            -- use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
        ft = { "markdown", "Avante" },
      },
    },
  },
}
