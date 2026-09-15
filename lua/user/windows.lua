vim.g.csharpls_path = "C:\\Users\\maya\\.dotnet\\tools\\csharp-ls.EXE"
vim.g.netcoredbg = "C:\\Users\\maya\\scoop\\shims\\netcoredbg.EXE"

vim.g.signer_path = vim.env.HOME .. "/AppData/Local/Programs/Microsoft VS Code/645f29cc31/resources/app/node_modules.asar.unpacked/vsda/build/Release/vsda.node"
vim.g.debugger_path = vim.env.HOME .. "/.vscode/extensions/ms-dotnettools.csharp-2.151.28-win32-x64/.debugger/x86_64/vsdbg-ui.exe"
vim.g.cppdbg_path = vim.env.HOME .. "/.vscode/extensions/ms-vscode.cpptools-1.35.1-win32-x64/debugAdapters/bin/OpenDebugAD7.exe"

vim.keymap.set('n', '<leader>t', '<cmd>sp | term pwsh -nol<cr>', {silent=true})
vim.keymap.set('n', '<leader>T', '<cmd>vsp | term pwsh -nol<cr>', {silent=true})

