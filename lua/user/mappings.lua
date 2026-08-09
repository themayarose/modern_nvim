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

vim.keymap.set('i', 'jj', '<esc>')
vim.keymap.set('i', '<m-enter>', '<Plug>delimitMateS-Tab')

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

vim.keymap.set('t', '<Esc><Esc>', [[<c-\><c-n><c-w><c-p>]])
vim.keymap.set('t', [[<c-\><c-\>]], [[<c-\><c-n>]])
vim.keymap.set('t', '<c-left>', [[<c-\><c-n><c-w>h]], {silent=true})
vim.keymap.set('t', '<c-down>', [[<c-\><c-n><c-w>j]], {silent=true})
vim.keymap.set('t', '<c-up>', [[<c-\><c-n><c-w>k]], {silent=true})
vim.keymap.set('t', '<c-right>', [[<c-\><c-n><c-w>l]], {silent=true})

vim.keymap.set('n', '<leader>bn', '<cmd>new<cr>', {silent=true})
vim.keymap.set('n', '<leader>bw', '<cmd>bp<cr><cmd>bw #<cr>', {silent=true})
vim.keymap.set('n', '<leader>bs', '<cmd>b #<cr>', {silent=true})
vim.keymap.set('n', '<leader>=', '<cmd>bn<cr>', {silent=true})
vim.keymap.set('n', '<leader>-', '<cmd>bp<cr>', {silent=true})
vim.keymap.set('n', '<leader>bg', function() vim.cmd('LualineBuffersJump! ' .. vim.v.count1) end)


vim.keymap.set('n', '<leader>0',  '<cmd>Vista finder<cr>', {silent=true})
vim.keymap.set('n', '<leader>pf', '<cmd>Files<cr>', {silent=true})
vim.keymap.set('n', '<leader>pg', '<cmd>GFiles<cr>', {silent=true})
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

vim.keymap.set({'x', 'n', 'v'}, '<leader>/', function() vim.lsp.buf.hover() end, {silent=true})
vim.keymap.set({'i', 'n'}, '<C-_>', function() vim.lsp.buf.signature_help() end, {silent=true})

vim.keymap.set('n', '<leader>ld', function() vim.lsp.buf.definition() end, {silent=true})
vim.keymap.set('n', '<leader>li', function() vim.lsp.buf.implementation() end, {silent=true})
vim.keymap.set('n', '<leader>la', function() vim.lsp.buf.code_action() end, {silent=true})
vim.keymap.set('n', '<leader>lr', function() vim.lsp.buf.references() end, {silent=true})
vim.keymap.set('n', '<leader>le', function() vim.diagnostic.open_float() end, {silent=true})
vim.keymap.set('n', '<leader>ln', function() vim.lsp.buf.rename() end, {silent=true})

vim.keymap.set('n', '<leader>]', function()
    local diagnostic = vim.diagnostic.get_next()

    if diagnostic ~= nil then
        vim.diagnostic.jump({diagnostic=diagnostic})
    end
end, {silent=true})

vim.keymap.set('n', '<leader>[', function()
    local diagnostic = vim.diagnostic.get_prev()

    if diagnostic ~= nil then
        vim.diagnostic.jump({diagnostic=diagnostic})
    end
end, {silent=true})

vim.keymap.set('n', '<leader>dr', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dea', function() require('dap').defaults.coreclr.exception_breakpoints = {'all'}; vim.print("Catch all exceptions.") end)
vim.keymap.set('n', '<Leader>deu', function() require('dap').defaults.coreclr.exception_breakpoints = {'user-unhandled'}; vim.print("Catch only unhandled exceptions.") end)

vim.keymap.set({'n', 'v'}, '<Leader>dh', function() require('dap.ui.widgets').hover() end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function() require('dap.ui.widgets').preview() end)
vim.keymap.set('n', '<Leader>df', function() require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames) end)
vim.keymap.set('n', '<Leader>ds', function() require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes) end)

vim.api.nvim_create_user_command('PlugUpdate', function() vim.pack.update() end, {})
