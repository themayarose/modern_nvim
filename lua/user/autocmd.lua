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

vim.api.nvim_create_autocmd("PackChanged", {
    desc = "Handle nvim-treesitter updates",
    group = vim.api.nvim_create_augroup("nvim-treesitter-pack-changed-update-handler", { clear = true }),
    callback = function (event)
        if event.data.kind == "update" then
            vim.notify("nvim-treesitter updated", vim.log.levels.INFO)
            ---@diagnostic disable-next-line: param-type-mismatch
            local ok = pcall(vim.cmd, "TSUpdate")
            if ok then
                vim.notify("nvim-treesitter tsupdate success", vim.log.levels.INFO)
            else
                vim.notify("nvim-treesitter tsupdate error", vim.log.levels.WARN)
            end
        end
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'cs', 'rs', 'razor', 'html', 'html' },
    callback = function() vim.treesitter.start() end,
})

-- vim.api.nvim_create_autocmd('VimResized', {
--     pattern = '*',
--     callback = function ()
--         vim.o.ead = 'hor'
--         vim.o.ea = true
--         vim.o.ea = false
--     end
-- })
