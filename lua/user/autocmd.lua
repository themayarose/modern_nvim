vim.api.nvim_create_autocmd({'BufWinEnter','WinEnter'}, {
    pattern = 'term://*',
    callback = function ()
        vim.cmd.startinsert()
        vim.cmd.setl('nonumber')
    end
})

vim.api.nvim_create_autocmd('TermOpen', {
    pattern = 'term://*',
    callback = function ()
        vim.cmd.setl('nonumber')
        vim.cmd.startinsert()
    end
})

vim.api.nvim_create_autocmd('BufReadPost', {
    pattern = 'quickfix',
    callback = function ()
        vim.keymap.set('n', '<cr>', '<cr>', { buf = 0 })
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'quickfix',
    callback = function ()
        vim.cmd.wincmd('J')
    end
})

vim.api.nvim_create_autocmd('VimResized', {
    pattern = '*',
    callback = function ()
        vim.o.ead = 'hor'
        vim.o.ea = true
        vim.o.ea = false
    end
})
