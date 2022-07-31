local cmd = vim.cmd

-- hover diagnostics
cmd([[
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- auto format
cmd([[
autocmd BufWritePre *.rs,*.lua lua vim.lsp.buf.formatting_sync(nil, 200)
]])

-- update stale but unmodified buffers
cmd([[
set autoread
autocmd FocusGained * checktime
]])
