local plugins = {
  -- Common Utilities
  { "nvim-lua/plenary.nvim", cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" }, lazy = true },
  { "nvim-lua/popup.nvim", lazy = true },
  "numToStr/Comment.nvim",
  "akinsho/toggleterm.nvim",
  "mbbill/undotree",
  {
    "nathom/filetype.nvim",
    -- lazy = true,
    config = function()
      require("thinasc.utilities.filetype").setup()
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    build = "cd app && npm install",
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_open_to_the_world = 1
      vim.g.mkdp_open_ip = "127.0.0.1"
      vim.g.mkdp_port = 8001
    end,
    ft = { "markdown" },
  },

  -- Theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   require("thinasc.core.tokyonight").setup()
    -- end,
  },

  -- UI
  {
    "nvim-tree/nvim-web-devicons", -- File Icons
    config = function()
      require("nvim-web-devicons").setup({
        -- your personnal icons can go here (to override)
        -- DevIcon will be appended to `name`
        override = {},
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true,
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua", -- File Explorer
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    -- config = function()
    --   require("thinasc.core.lualine").setup()
    -- end,
  },
  "preservim/tagbar", -- TagBar
  "onsails/lspkind-nvim", -- VSCode-like pictograms
  {
    "norcalli/nvim-colorizer.lua",
    -- lazy = true,
    config = function()
      require("colorizer").setup({ "*" })
    end,
  }, -- Color Highlighter
  "lukas-reineke/indent-blankline.nvim", -- Indent Guides
  "akinsho/bufferline.nvim", -- Buffer Tab Line
  "j-hui/fidget.nvim",

  -- Completion
  "folke/which-key.nvim", -- Which Key
  "hrsh7th/nvim-cmp", -- The Completion Plugin
  "hrsh7th/cmp-buffer", -- Buffer Completions
  "hrsh7th/cmp-path", -- Path Completions
  "hrsh7th/cmp-cmdline", -- Command Line Completions
  "saadparwaiz1/cmp_luasnip", -- Snippet Completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        disable_filetype = {
          "TelescopePrompt",
          "vim",
        },
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    -- lazy = true
  },

  -- Snippets
  "L3MON4D3/LuaSnip", -- Snippet Engine
  "rafamadriz/friendly-snippets", -- A bunch of snippets to use

  -- Git
  "lewis6991/gitsigns.nvim", -- Git Signs
  "sindrets/diffview.nvim", -- Diffview

  -- TreeSitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  "nvim-treesitter/nvim-treesitter-context",
  "JoosepAlviste/nvim-ts-context-commentstring",

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "telescope-fzf-native.nvim",
    },
    lazy = true,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    lazy = true,
  }, -- Dependency for Better Sorting Performance

  -- LSP
  "VonHeikemen/lsp-zero.nvim",
  "neovim/nvim-lspconfig", -- LSP Config
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  {
    "glepnir/lspsaga.nvim",
    -- lazy = true,
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          enable = true,
          separator = "  ",
        },
      })
    end,
    -- dependencies = {
    --   "nvim-tree/nvim-web-devicons",
    -- }
  },
  -- use "jose-elias-alvarez/typescript.nvim"   -- Add functionality for typescript server (e.g. rename file & update imports)
  "jose-elias-alvarez/null-ls.nvim", -- Use Neovim as a Language Server to inject LSP diagnostics, Code Actions and more via Lua
}

return plugins
