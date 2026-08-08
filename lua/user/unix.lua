vim.g.csharpls_path = "/usr/sbin/csharp-ls"
vim.g.netcoredbg = "/usr/sbin/netcoredbg"

vim.g.signer_path = "/usr/share/code/resources/app/node_modules.asar.unpacked/vsda/build/Release/vsda.node"
vim.g.debugger_path = vim.env.HOME .. "/.vscode/extensions/ms-dotnettools.csharp-2.140.9-linux-x64/.debugger/vsdbg-ui"

vim.keymap.set('n', '<leader>t', '<cmd>sp | term<cr>', {silent=true})
vim.keymap.set('n', '<leader>T', '<cmd>vsp | term<cr>', {silent=true})

