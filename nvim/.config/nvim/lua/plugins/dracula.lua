local dracula = require("dracula")
local colors = dracula.colors()
dracula.setup({
    overrides = {
        NvimTreeNormal = { fg = colors.fg, bg = colors.bg, },
        NvimTreeVertSplit = { fg = colors.gutter_fg, bg = colors.bg, },
    },
})


vim.cmd([[
    colorscheme dracula
]])
