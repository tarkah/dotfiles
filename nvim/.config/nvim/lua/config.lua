local cmd = vim.cmd

-- hover diagnostics
cmd([[
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- auto format
cmd([[
autocmd BufWritePre * lua vim.lsp.buf.format({ filter = function(client) return client.name ~= "tsserver" end })
]])

-- update stale but unmodified buffers
cmd([[
set autoread
autocmd FocusGained * checktime
]])
