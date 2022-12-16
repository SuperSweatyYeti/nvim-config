local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim"} -- Have packer manage itself
  use { "nvim-lua/plenary.nvim"} -- Useful lua functions used by lots of plugins
-- Comment Plugin use gc or gb in visual mode
  use {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup {} end
  }
	-- File Explorer in Vim leader+f
  use { "kyazdani42/nvim-web-devicons"}
  use { "kyazdani42/nvim-tree.lua"}
  -- use { "preservim/nerdtree"}
	use { "akinsho/bufferline.nvim", tag = "v3.*", requires = "kyazdani42/nvim-web-devicons"}  use { "moll/vim-bbye"}
	-- Pretty status bar
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	-- Terminal Toggle
  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
		end
	}
	-- Use Ctrl+fp to list recent git projects
	use { 
		"ahmedkhalf/project.nvim",
    config = function() require("project_nvim").setup {} end
	}
  use { "lewis6991/impatient.nvim"} -- faster startup

  -- Smart Indentation
  use { "lukas-reineke/indent-blankline.nvim"}
  
  -- Hex Color Previewer
  use { "uga-rosa/ccc.nvim"}
-- 
  -- Vim Surround
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
})
  -- Multi-cursor
  use { "mg979/vim-visual-multi" }


  -- Braces Auto-pairs (Only use if not usign coq. IF using coc then use ":CocInstall coc-snippets" instead)
  -- use {
  --   "windwp/nvim-autopairs",
  --     config = function() require("nvim-autopairs").setup {} end
  -- }
  


  -- Vim Surround tips
  -- after highlighting selection press 'S<bracketType>' to surround selection




	-- alpha dashboard
  use {
			'goolord/alpha-nvim',
			requires = { 'kyazdani42/nvim-web-devicons' },
			config = function ()
					require'alpha'.setup(require'alpha.themes.startify'.config)
			end
	} 

  -- Colorschemes
  use { "folke/tokyonight.nvim"}
  use { "lunarvim/darkplus.nvim"}
  use { "arcticicestudio/nord-vim" }
  use { "bluz71/vim-moonfly-colors" }
  use { "joshdick/onedark.vim" }
  use { "rebelot/kanagawa.nvim" }
  use { "nanotech/jellybeans.vim" }
  use { "catppuccin/nvim" }
  use { "a5hk/night-coder" }
  use { "Everblush/everblush.vim" }
  use { "tomasiser/vim-code-dark" }

  -- LSP and Linting
  -- code completion coc
  use { "neoclide/coc.nvim", branch ="release" } -- enable LSP

  -- code completion coq
  use { "ms-jpq/coq_nvim", branch ="coq" } -- enable LSP
  
  -- 9000+ Snippets
  use { "ms-jpq/coq.artifacts", branch ="artifacts" }


  use { "neovim/nvim-lspconfig"} -- enable LSP
  use { "williamboman/mason.nvim"}
  use { "williamboman/mason-lspconfig.nvim"}
  use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null-ls").setup()
		end,
		requires = { "nvim-lua/plenary.nvim" },
	}) 
	use {
    "brymer-meneses/grammar-guard.nvim",
    requires = {
        "neovim/nvim-lspconfig",
        "williamboman/nvim-lsp-installer"
    }
	}

	-- Quick word search under cursor alt+p and alt+n
  use { "RRethy/vim-illuminate"}

  -- Telescope
  use { "nvim-telescope/telescope.nvim"}

  -- Qiuckscope
  -- Highlight on f and F keys Set in init.lua
  use { "unblevable/quick-scope" }



  -- Rainbow -- Colored Nested Braces levels
  use { "p00f/nvim-ts-rainbow" }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter" }
  


  -- Git
  use { "lewis6991/gitsigns.nvim"}

  -- Titus Custom
  use { "ekickx/clipboard-image.nvim" }
  use { "mbbill/undotree" }
  -- use { "wakatime/vim-wakatime" }
  -- use { "Pocco81/auto-save.nvim" }
  use { "Pocco81/true-zen.nvim" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
