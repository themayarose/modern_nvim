vim.keymap.set({'n', 'v', 'x'}, '"', '#')
vim.keymap.set({'n', 'v', 'x'}, '#', '"')
vim.keymap.set({'n', 'v', 'x'}, ':', ';')
vim.keymap.set({'n', 'v', 'x'}, ';', ':')
vim.keymap.set({'n', 'v', 'x'}, 'j', 'gj')
vim.keymap.set({'n', 'v', 'x'}, 'k', 'gk')
vim.keymap.set({'n', 'v', 'x'}, 'gj', 'j')
vim.keymap.set({'n', 'v', 'x'}, 'gk', 'k')



vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', 'q:', '<nop>')
vim.keymap.set('n', 'q/', '<nop>')
vim.keymap.set('n', 'q?', '<nop>')

vim.keymap.set('n', '<leader>T', '<cmd>vsp | term pwsh -nol<cr>', {silent=true})
vim.keymap.set('n', '<leader>t', '<cmd>sp | term pwsh -nol<cr>', {silent=true})

vim.keymap.set('i', 'jj', '<esc>')

vim.keymap.set('n', '<leader>a', '<C-w>h', {silent=true})
vim.keymap.set('n', '<leader>w', '<C-w>k', {silent=true})
vim.keymap.set('n', '<leader>s', '<C-w>j', {silent=true})
vim.keymap.set('n', '<leader>d', '<C-w>l', {silent=true})
vim.keymap.set('n', '<leader>q', '<C-w>q', {silent=true})
vim.keymap.set('n', '<leader>r', '<C-w>r', {silent=true})
vim.keymap.set('n', '<leader>A', '<C-w>H', {silent=true})
vim.keymap.set('n', '<leader>W', '<C-w>K', {silent=true})
vim.keymap.set('n', '<leader>S', '<C-w>J', {silent=true})
vim.keymap.set('n', '<leader>D', '<C-w>L', {silent=true})

vim.keymap.set('n', '+', '<C-w>+')
vim.keymap.set('n', '-', '<C-w>-')
vim.keymap.set('n', '<c-+>', '<C-w>>')
vim.keymap.set('n', '<c-->', '<C-w><')

vim.keymap.set('t', '<Esc><Esc>', '<c-leader><c-n><c-w><c-p>')
vim.keymap.set('t', '<c-leader><c-leader>', '<c-leader><c-n>')
vim.keymap.set('t', '<c-left>', '<c-leader><c-n><c-w>h', {silent=true})
vim.keymap.set('t', '<c-down>', '<c-leader><c-n><c-w>j', {silent=true})
vim.keymap.set('t', '<c-up>', '<c-leader><c-n><c-w>k', {silent=true})
vim.keymap.set('t', '<c-right>', '<c-leader><c-n><c-w>l', {silent=true})

vim.keymap.set('n', '<leader>bn', '<cmd>new<cr>', {silent=true})
vim.keymap.set('n', '<leader>bw', '<cmd>bp<cr><cmd>bw #<cr>', {silent=true})
vim.keymap.set('n', '<leader>w', '<cmd>bp<cr><cmd>bw #<cr>', {silent=true})
vim.keymap.set('n', '<leader>bs', '<cmd>b #<cr>', {silent=true})
vim.keymap.set('n', '<leader>=', '<cmd>bn<cr>', {silent=true})
vim.keymap.set('n', '<leader>-', '<cmd>bp<cr>', {silent=true})
vim.keymap.set('n', '<leader>bg', function() return '<cmd>b ' .. vim.v.count .. '<cr>' end, {silent=true})


vim.keymap.set('n', '<F2>', '<cmd>Vista !!<cr><c-w><c-p>', {silent=true})
vim.keymap.set('n', '<leader>0',  '<cmd>Vista finder<cr>', {silent=true})
vim.keymap.set('n', '<leader>pf', '<cmd>Files<cr>', {silent=true})
vim.keymap.set('n', '<leader>bf', '<cmd>Buffers<cr>', {silent=true})


vim.keymap.set('n', '<leader>mb', function() vim.cmd('Neomake!') end)
vim.keymap.set('n', '<leader>mr', function() vim.cmd('Neomake! restore') end)
vim.keymap.set('n', '<leader>me', function() vim.cmd('copen') end)

vim.keymap.set('x', '<Tab>', '>gv', {silent=true})
vim.keymap.set('x', '<S-Tab>', '<gv', {silent=true})
vim.keymap.set('n', '<Tab>', '>>', {silent=true})
vim.keymap.set('n', '<S-Tab>', '<<', {silent=true})

-- Easymotion
vim.keymap.set({'n'}, '<leader>f', '<Plug>(easymotion-overwin-f)')
vim.keymap.set({'n'}, '<leader>2', '<Plug>(easymotion-overwin-f2)')
vim.keymap.set({'n'}, '<leader>mw', '<Plug>(easymotion-overwin-w)')
vim.keymap.set({'n'}, '<leader>ml', '<Plug>(easymotion-overwin-line)')
vim.keymap.set({'n'}, '<leader>mt', '<Plug>(easymotion-bd-t)')

-- Completion

vim.keymap.set({'x', 'n', 'v'}, '<leader>/', '<cmd>lua vim.lsp.buf.hover()<cr>', {silent=true})
vim.keymap.set({'i', 'n'}, '<C-_>', '<cmd>LspOverloads signature<cr>', {silent=true})

vim.keymap.set('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>', {silent=true})
vim.keymap.set('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<cr>', {silent=true})
vim.keymap.set('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', {silent=true})
vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<cr>', {silent=true})
vim.keymap.set('n', '<leader>le', '<cmd>lua vim.diagnostic.open_float()<cr>', {silent=true})
vim.keymap.set('n', '<leader>ln', '<cmd>lua vim.lsp.buf.rename()<cr>', {silent=true})

vim.keymap.set('n', '<leader>dr', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dea', function() require('dap').defaults.coreclr.exception_breakpoints = {'all'}; vim.print("Catch all exceptions.") end)
vim.keymap.set('n', '<Leader>deu', function() require('dap').defaults.coreclr.exception_breakpoints = {'user-unhandled'}; vim.print("Catch only unhandled exceptions.") end)

vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)

vim.api.nvim_create_user_command('PlugUpdate', function() vim.pack.update() end, {})
