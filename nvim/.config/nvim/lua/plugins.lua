vim.cmd [[packadd packer.nvim]]
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
end

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- LSP config
    use { "neovim/nvim-lspconfig", config = [[ require('plugins/lspconfig') ]] }
    use { 'simrat39/rust-tools.nvim', config = [[ require('plugins/rust-tools') ]] }
    use { 'jose-elias-alvarez/null-ls.nvim', config = [[ require('plugins/null-ls') ]] }

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = [[ require('plugins/nvim-treesitter') ]] }

    -- Color
    --use { "sainnhe/gruvbox-material", config = [[ require('plugins/colorscheme') ]] }
    --use { "Mofiqul/dracula.nvim", config = [[ require('plugins/colorscheme') ]] }
    use { "shaunsingh/nord.nvim", config = [[ require('plugins/colorscheme') ]] }


    -- Auto completion
    use { 'hrsh7th/nvim-cmp', config = [[ require('plugins/nvim-cmp') ]] }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'hrsh7th/cmp-vsnip' }

    -- Snippets
    use { 'hrsh7th/vim-vsnip' }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = [[ require('plugins/telescope') ]]
    }
    use { 'nvim-telescope/telescope-ui-select.nvim' }
    use { 'stevearc/dressing.nvim' }

    -- Whichkey
    use { "folke/which-key.nvim", config = [[ require('plugins/which-key') ]] }

    -- Status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { { 'kyazdani42/nvim-web-devicons' }, { 'arkav/lualine-lsp-progress' } },
        config = [[ require('plugins/lualine') ]]
    }

    -- Tabs
    use { 'romgrk/barbar.nvim', requires = { 'kyazdani42/nvim-web-devicons' }, disable = true, opt = true }

    -- Explorer
    use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' },
        config = [[ require('plugins/nvim-tree') ]] }

    -- Sneak
    use 'justinmk/vim-sneak'

    -- Comment text in and out
    use 'b3nj5m1n/kommentary'

    -- Git
    use 'tpope/vim-fugitive'
    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim',
    }

    -- Dashboard
    use { 'goolord/alpha-nvim', config = [[ require('plugins/alpha-nvim') ]] }

    -- Sessions
    use { 'Shatur/neovim-session-manager', requires = { 'nvim-lua/plenary.nvim' },
        config = [[ require('plugins/neovim-session-manager') ]] }

    if packer_bootstrap then
        require('packer').sync()
    end
end)
