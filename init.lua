vim.loader.enable()

if vim.fn.has("win32") == 1 then
    require('user.windows')
else
    require('user.unix')
end

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
