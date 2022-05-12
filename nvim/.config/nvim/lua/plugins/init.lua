local packer = prequire("plugins.packerInit")

local use = packer.use

return require("packer").startup(function()
  use({ "nvim-lua/plenary.nvim" })

  use({ "lewis6991/impatient.nvim" })

  use({
    "wbthomason/packer.nvim",
    event = "VimEnter",
  })

  use({ "antoinemadec/FixCursorHold.nvim" })

  use({
    "lukas-reineke/indent-blankline.nvim",
    ft = { "python" },
    config = function()
      require("plugins.configs.others").indent_blankline()
    end,
  })

  use({
    "NvChad/nvterm",
    config = function()
      require("plugins.configs.others").nvterm()
    end,
    setup = function()
      require("core.mappings").nvterm()
    end,
  })

  use("MunifTanjim/nui.nvim")

  use({
    "bennypowers/nvim-regexplainer",
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
    event = "BufRead",
    config = function()
      require("plugins.configs.others").regexplainer()
    end,
    setup = function()
      packer_lazy_load("nvim-regexplainer")
    end,
  })

  use("nvim-treesitter/playground")

  use({
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.configs.icons")
    end,
    setup = function()
      packer_lazy_load("nvim-web-devicons")
    end,
  })

  use({
    "feline-nvim/feline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require("plugins.configs.feline")
    end,
  })

  use({
    "akinsho/bufferline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require("plugins.configs.bufferline")
    end,
    setup = function()
      require("core.mappings").bufferline()
    end,
  })

  use({
    "NvChad/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("plugins.configs.others").colorizer()
    end,
  })

  use({ "b0o/schemastore.nvim" })

  use({ "mattn/emmet-vim" })

  use({
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("plugins.configs.treesitter")
    end,
    run = ":TSUpdate",
  })

  use({ "JoosepAlviste/nvim-ts-context-commentstring" })

  use({ "windwp/nvim-ts-autotag" })

  use({ "p00f/nvim-ts-rainbow" })

  use({ "nvim-treesitter/nvim-treesitter-textobjects" })

  -- git stuff
  use({
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("plugins.configs.others").gitsigns()
    end,
    setup = function()
      packer_lazy_load("gitsigns.nvim")
    end,
  })

  use({
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
    setup = function()
      packer_lazy_load("octo.nvim")
    end,
  })

  use({
    "sindrets/diffview.nvim",
    after = "nvim-web-devicons",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("diffview").setup()
    end,
    setup = function()
      packer_lazy_load("diffview.nvim")
    end,
  })

  -- lsp stuff

  use({
    "neovim/nvim-lspconfig",
    module = "lspconfig",
    after = "nvim-lsp-installer",
    config = function()
      require("plugins.configs.others").lsp_installer()
      require("plugins.configs.lspconfig")
    end,
    setup = function()
      packer_lazy_load("nvim-lspconfig")
      -- reload the current file so lsp actually starts for it
      vim.defer_fn(function()
        vim.cmd('if &ft == "packer" | echo "" | else | silent! e %')
      end, 0)
    end,
  })

  use({ "williamboman/nvim-lsp-installer" })

  use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("plugins.configs.others").null_ls()
    end,
  })

  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end,
  })

  -- use({
  --   "Mofiqul/trld.nvim",
  --   config = function()
  --     require("trld").setup()
  --   end,
  -- })

  use({
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    config = function()
      require("plugins.configs.others").better_escape()
    end,
  })

  -- load luasnips + cmp related in insert mode only

  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.configs.cmp")
    end,
  })

  use({
    "L3MON4D3/LuaSnip",
    after = "nvim-cmp",
    event = "BufEnter",
    config = function()
      require("plugins.configs.luasnip")
    end,
    setup = function()
      packer_lazy_load("LuaSnip")
    end,
  })

  use({
    "saadparwaiz1/cmp_luasnip",
    after = "LuaSnip",
  })

  use({
    "hrsh7th/cmp-nvim-lua",
    after = "cmp_luasnip",
  })

  use({
    "hrsh7th/cmp-nvim-lsp",
    after = "cmp-nvim-lua",
  })

  use({
    "hrsh7th/cmp-buffer",
    after = "cmp-nvim-lsp",
  })

  use({
    "hrsh7th/cmp-path",
    after = "cmp-buffer",
  })

  -- misc plugins
  use({
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").autopairs()
    end,
  })

  use({
    "numToStr/Comment.nvim",
    module = "Comment",
    setup = function()
      require("core.mappings").comment()
    end,

    config = function()
      require("plugins.configs.others").comment()
    end,
  })

  -- file managing , picker etc
  use({
    "kyazdani42/nvim-tree.lua",

    config = function()
      require("plugins.configs.nvimtree")
    end,

    setup = function()
      require("core.mappings").nvimtree()
    end,
  })

  use({
    "nvim-telescope/telescope.nvim",
    module = "telescope",
    cmd = "Telescope",

    config = function()
      require("plugins.configs.telescope")
    end,

    setup = function()
      require("core.mappings").telescope()
    end,
  })
  use({ "nvim-telescope/telescope-ui-select.nvim", requires = "nvim-telescope/telescope.nvim" })
  use({ "nvim-telescope/telescope-file-browser.nvim", requires = "nvim-telescope/telescope.nvim" })
  use({ "nvim-telescope/telescope-cheat.nvim", requires = "nvim-telescope/telescope.nvim" })
  use({ "nvim-telescope/telescope-fzf-native.nvim", requires = "nvim-telescope/telescope.nvim", run = "make" })

  use({
    "ur4ltz/surround.nvim",
    config = function()
      require("surround").setup({ mappings_style = "sandwich" })
    end,
  })

  use({
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup()
    end,
    setup = function()
      packer_lazy_load("neoscroll.nvim")
      require("core.mappings").neoscroll()
    end,
  })

  use({
    "nvim-neorg/neorg",
    ft = "norg",
    after = "nvim-treesitter",
    config = function()
      require("plugins.configs.others").neorg()
    end,
    setup = function()
      packer_lazy_load("neorg")
    end,
  })

  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
    setup = function()
      packer_lazy_load("todo-comments.nvim")
    end,
  })

  use({
    "luukvbaal/stabilize.nvim",
    config = function()
      require("stabilize").setup()
    end,
  })

  use({
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("crates").setup()
    end,
  })

  use({
    "rcarriga/nvim-notify",
    requires = "nvim-telescope/telescope.nvim",
    config = function()
      vim.notify = require("notify")
    end,
    setup = function()
      packer_lazy_load("nvim-notify")
    end,
  })

  use({
    "numToStr/Navigator.nvim",
    config = function()
      require("Navigator").setup()
    end,
    setup = function()
      require("core.mappings").navigator()
    end,
  })

  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
    setup = function()
      require("core.mappings").trouble()
    end,
  })

  use({ "folke/tokyonight.nvim" })

  use({ "tami5/sqlite.lua" })

  use({
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugins.configs.others").project()
    end,
  })

  use({
    "mfussenegger/nvim-dap",
    config = function()
      require("plugins.configs.dap")
    end,
    setup = function()
      require("core.mappings").dap()
    end,
  })
end)
