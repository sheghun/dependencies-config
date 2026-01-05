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
    version = "v2.5.0",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
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
        "eslint",
        "basedpyright",
        "black",
        "sqlls",
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
      ---@diagnostic disable-next-line: different-requires
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
      "mxsdev/nvim-dap-vscode-js", -- For JS/TS debugging
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

  -- {
  --   "yetone/avante.nvim",
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   -- ⚠️ must add this setting! ! !
  --   build = function()
  --     -- conditionally use the correct build system for the current OS
  --     if vim.fn.has "win32" == 1 then
  --       return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
  --     else
  --       return "make"
  --     end
  --   end,
  --   event = "VeryLazy",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "echasnovski/mini.pick", -- for file_selector provider mini.pick
  --     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  --     "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  --     "ibhagwan/fzf-lua", -- for file_selector provider fzf
  --     "stevearc/dressing.nvim", -- for input provider dressing
  --     "folke/snacks.nvim", -- for input provider snacks
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     "zbirenbaum/copilot.lua", -- for providers='copilot'
  --     "ravitemer/mcphub.nvim",
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  --
  --   system_prompt = function()
  --     local hub = require("mcphub").get_hub_instance()
  --     return hub and hub:get_active_servers_prompt() or ""
  --   end,
  --   -- Using function prevents requiring mcphub before it's loaded
  --   custom_tools = function()
  --     return {
  --       require("mcphub.extensions.avante").mcp_tool(),
  --     }
  --   end,
  --   version = false, -- Never set this value to "*"! Never!
  --   ---@module 'avante'
  --   ---@type avante.Config
  --   opts = {
  --     -- add any opts here
  --     -- for example
  --     provider = "claude",
  --     providers = {
  --       claude = {
  --         endpoint = "https://api.anthropic.com",
  --         model = "claude-3-7-sonnet-20250219",
  --         timeout = 30000, -- Timeout in milliseconds
  --         extra_request_body = {
  --           temperature = 0.75,
  --           max_tokens = 20480,
  --         },
  --       },
  --       ollama = {
  --         endpoint = "http://localhost:11434",
  --         -- model = "deepseek-r1:14b",
  --         model = "qwen2.5-coder:latest",
  --       },
  --       moonshot = {
  --         endpoint = "https://api.moonshot.ai/v1",
  --         model = "kimi-k2-0711-preview",
  --         timeout = 30000, -- Timeout in milliseconds
  --         extra_request_body = {
  --           temperature = 0.75,
  --           max_tokens = 32768,
  --         },
  --       },
  --     },
  --   },
  --
  --   -- disabled_tools = {
  --   --   "list_files",
  --   --   "search_files",
  --   --   "read_file",
  --   --   "create_file",
  --   --   "rename_file",
  --   --   "delete_file",
  --   --   "create_dir",
  --   --   "rename_dir",
  --   --   "delete_dir",
  --   --   "bash",
  --   -- },
  --
  --   -- File selector configuration
  --   file_selector = {
  --     provider = "telescope",
  --   },
  -- },

  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = false,
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup()
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      local harpoon = require "harpoon"
      harpoon.setup()

      require("telescope").load_extension "harpoon"

      vim.keymap.set("n", "<leader>hm", function()
        require("telescope").extensions.harpoon.marks()
      end, { desc = "Open harpoon window" })

      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():add()
      end)
      -- vim.keymap.set("n", "<leader>hm", function()
      --   harpoon.ui:toggle_quick_menu(harpoon:list())
      -- end)
      vim.keymap.set("n", "<leader>h1", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<leader>h2", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<leader>h3", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<leader>h4", function()
        harpoon:list():select(4)
      end)
    end,
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    config = function()
      -- Disable auto-save for DBUI buffers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "dbui", "dbout", "sql" },
        callback = function()
          vim.b.auto_save = false
        end,
      })
    end,
  },

  {
    "coder/claudecode.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    opts = {
      terminal_cmd = "/Users/segunoladiran/.local/bin/claude",
    },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add buffer to Claude" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude conversation" },
      { "<leader>ao", "<cmd>ClaudeCode --continue<cr>", desc = "Continue last Claude conversation" },
    },
  },
}
