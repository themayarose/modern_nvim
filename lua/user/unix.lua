vim.g.csharpls_path = "/usr/sbin/csharp-ls"
vim.g.netcoredbg = "/usr/sbin/netcoredbg"
vim.g.dotnet_debugger = "netcoredbg"

vim.keymap.set('n', '<leader>t', '<cmd>sp | term<cr>', {silent=true})
vim.keymap.set('n', '<leader>T', '<cmd>vsp | term<cr>', {silent=true})

