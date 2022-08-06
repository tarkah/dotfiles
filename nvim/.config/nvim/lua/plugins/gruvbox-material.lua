vim.g.gruvbox_material_palette = "material"
vim.cmd([[
    syntax on 
    if (has("termguicolors"))
      set termguicolors
      set background=dark
      hi LineNr ctermbg=NONE guibg=NONE
    endif
    colorscheme gruvbox-material
]])
