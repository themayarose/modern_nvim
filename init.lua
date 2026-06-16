vim.loader.enable()

require('user.mappings')
require('user.plugins')
require('user.options')
require('user.autocmd')

vim.cmd.colorscheme('gruvbox')

vim.cmd([[
    highlight Normal guibg=NONE
    highlight NonText guibg=NONE
    highlight SignColumn guibg=NONE
]])
