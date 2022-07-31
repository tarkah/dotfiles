vim.cmd [[packadd packer.nvim]]
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- LSP config
  use {"neovim/nvim-lspconfig", config = [[ require('plugins/lspconfig') ]]}
  use {'simrat39/rust-tools.nvim', config = [[ require('plugins/rust-tools') ]]}

  -- Treesitter
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = [[ require('plugins/nvim-treesitter') ]]}

  -- Color
  use {
    "sainnhe/gruvbox-material",
    config = function()
        vim.g.gruvbox_material_palette = "material"
        vim.cmd([[
            syntax on 
            if (has("termguicolors"))
              set termguicolors
              hi LineNr ctermbg=NONE guibg=NONE
            endif
            colorscheme gruvbox-material
        ]])
    end
  }

  -- Auto completion
  use {'hrsh7th/nvim-cmp', config = [[ require('plugins/nvim-cmp') ]]}
  use {'hrsh7th/cmp-nvim-lsp'}
  use {'hrsh7th/cmp-buffer'}
  use {'hrsh7th/cmp-path'}
  use {'hrsh7th/cmp-cmdline'}
  use {'hrsh7th/cmp-vsnip'}

  -- Snippets
  use {'hrsh7th/vim-vsnip'}

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
        require("telescope").setup {
          defaults = {
              mappings = {
                  n = {
                      ["<C-c>"] = "close",
                  },
              },
          },
          pickers = {
              diagnostics = {
                  root_dir = "/home/tarkah/projects",
              },
          },
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown {
                -- even more opts
              }
            }
          }
        }
        -- To get fzf loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        require("telescope").load_extension("ui-select")
    end
  }
  use {'nvim-telescope/telescope-ui-select.nvim' }
  use {'stevearc/dressing.nvim', config = function ()
      require('dressing').setup({
          select = {
              enabled = false,
          }
      })
  end}

  -- Whichkey
  use {
  "folke/which-key.nvim",
  config = function()
      require("which-key").setup {
          plugins = {
              marks = true, -- shows a list of your marks on ' and `
              registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
              -- the presets plugin, adds help for a bunch of default keybindings in Neovim
              -- No actual key bindings are created
          },
          window = {
              border = "single", -- none, single, double, shadow
              position = "bottom", -- bottom, top
          },
      }
    end
  }

  -- minimap
  use {
      'wfxr/minimap.vim',
      run = "cargo install --locked code-minimap",
      cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
      config = function ()
          vim.cmd ("let g:minimap_width = 10")
          vim.cmd ("let g:minimap_auto_start = 1")
          vim.cmd ("let g:minimap_auto_start_win_enter = 1")
      end,
  }

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = {{ 'kyazdani42/nvim-web-devicons'}, {'arkav/lualine-lsp-progress'}},
    config = function()
        require('lualine').setup {
            sections = {
              lualine_b = {
                'branch',
                'diff',
                {
                  'diagnostics',
                  -- .get() for project wide counts (repo uses .get(0) for buffer only)
                  sources = {
                      function()
                        local diagnostics = vim.diagnostic.get()
                        local count = { 0, 0, 0, 0 }
                        for _, diagnostic in ipairs(diagnostics) do
                          local name = vim.api.nvim_buf_get_name(diagnostic.bufnr)
                          local whitelist_dir = "/home/tarkah/projects"
                          local allowed = string.sub(name, 1, #whitelist_dir) == whitelist_dir

                          if allowed then
                            count[diagnostic.severity] = count[diagnostic.severity] + 1
                          end

                        end
                        return {
                            error = count[vim.diagnostic.severity.ERROR],
                            warn = count[vim.diagnostic.severity.WARN],
                            info = count[vim.diagnostic.severity.INFO],
                            hint = count[vim.diagnostic.severity.HINT],
                        }
                      end
                  },
                }
              },
              lualine_c = {
                  {
                    'filename',
                    path = 1,
                  },
                  {
        			'lsp_progress',
                	-- With spinner
                	display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' }},
                	separators = {
                		component = ' ',
                		progress = ' | ',
                		message = { pre = '(', post = ')'},
                		percentage = { pre = '', post = '%% ' },
                		title = { pre = '', post = ': ' },
                		lsp_client_name = { pre = '[', post = ']' },
                		spinner = { pre = '', post = '' },
                		message = { commenced = 'In Progress', completed = 'Completed' },
                	},
                	display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
                	timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
                	spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
                }
              }
            },
            inactive_sections = {
                lualine_c = {},
                lualine_x = {'location'}
            }
        }
    end
  }

  -- Tabs
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    disable = true,
    opt = true,
  }

  -- Explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() 
        require'nvim-tree'.setup {
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
        } 
    end
  }

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
  use {
    'goolord/alpha-nvim',
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
  }

  -- Sessions
  use {
    'Shatur/neovim-session-manager',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
        local Path = require('plenary.path')
        require('session_manager').setup({
          sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
          path_replacer = '__', -- The character to which the path separator will be replaced for session files.
          colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.
          autoload_mode = require('session_manager.config').AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
          autosave_last_session = true, -- Automatically save last session on exit and on session switch.
          autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
          autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
            'gitcommit',
          }, 
          autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
          max_path_length = 80,  -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
        })
    end
  }

  -- tmux
  use({
      "aserowy/tmux.nvim",
      config = function()
          require("tmux").setup({
              navigation = {
                  -- enables default keybindings (C-hjkl) for normal mode
                  enable_default_keybindings = true,
              },
              resize = {
                  -- enables default keybindings (A-hjkl) for normal mode
                  enable_default_keybindings = true,
              }
          })
      end
  })

  if packer_bootstrap then
    require('packer').sync()
  end
end)


