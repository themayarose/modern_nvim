vim.pack.add({
    'https://github.com/morhetz/gruvbox',
    'https://github.com/vim-airline/vim-airline',
    'https://github.com/junegunn/fzf',
    'https://github.com/junegunn/fzf.vim',
    'https://github.com/liuchengxu/vista.vim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/Decodetalkers/csharpls-extended-lsp.nvim',
    'https://github.com/Issafalcon/lsp-overloads.nvim',
    'https://github.com/neomake/neomake',
    'https://codeberg.org/mfussenegger/nvim-dap.git',
    'https://github.com/rcarriga/nvim-dap-ui',
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/theHamsta/nvim-dap-virtual-text',
    { src='https://github.com/ms-jpq/coq_nvim', version='coq' },
    { src='https://github.com/ms-jpq/coq.artifacts', version='artifacts' },
    { src='https://github.com/ms-jpq/coq.thirdparty', version='3p' },
    'https://github.com/Raimondi/delimitMate',
    'https://github.com/tpope/vim-surround',
    'https://github.com/tpope/vim-commentary',
    'https://github.com/kana/vim-textobj-user',
    'https://github.com/kana/vim-textobj-indent',
    'https://github.com/godlygeek/tabular',
    'https://github.com/easymotion/vim-easymotion',
    'https://github.com/wellle/targets.vim',
    'https://github.com/rust-lang/rust.vim',
    'https://github.com/sheerun/vim-polyglot',
    'https://github.com/ncm2/float-preview.nvim',
})

-- Airline
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#buffer_nr_show'] = 1
vim.g['airline#extensions#tabline#show_buffers'] = 2
vim.g['airline#extensions#tabline#ignore_bufadd_pat'] = '!|defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'

-- FZF
vim.g.fzf_action = { ['ctrl-x']='split', ['ctrl-v']='vsplit' }

-- Vista
vim.g.vista_executive_for = { cs='nvim_lsp', rs='nvim_lsp' }

-- COQ
local coq = require("coq")
local _border = "rounded"

vim.g.coq_settings = {
    limits={
       idle_timeout=0.1,
       completion_auto_timeout=1.5,
       completion_manual_timeout=2.5,
    },
    clients={
       ['lsp.always_on_top']={},
       ["tmux.enabled"]=false,
       ['buffers.enabled']=false,
       ["registers.enabled"]=false,
    },
}

vim.diagnostic.config({
    signs = { severity = { min = vim.diagnostic.severity.WARN } },
    underline = { severity = { min = vim.diagnostic.severity.HINT } },
})


vim.lsp.config('csharp_ls', {
    cmd = { vim.g.csharpls_path, "-l", "info" },
    filetypes = { "cs" },
    enable_editorconfig_support = true,
    enable_ms_build_load_projects_on_demand = true,
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
    sdk_include_prereleases = true,
    analyze_open_documents_only = false,
    root_dir =
        vim.fs.root(
            0,
            function (name, path)
                return name:match('%.slnx?$') ~= nil
            end
        ),
})

vim.lsp.config('rust_analyzer', {
    ['rust-analyzer.diagnostics.enable'] = true
})

require("csharpls_extended").buf_read_cmd_bind()

require('lsp-overloads').setup({
    ui = {
        border = _border
    },
    keymaps = {
        close_signature = "<esc>"
    },
    display_automatically = false
})

coq.setup()

vim.lsp.enable('rust_analyzer')
vim.lsp.enable('csharp_ls')
vim.lsp.enable('lua_ls')

-- DAP

local dap = require("dap")
local ui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")

dap_virtual_text.setup()

ui.setup()

vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

dap.adapters.coreclr = function(cb, config)
    local path = vim.fn.getcwd() .. "\\netcoredbg.file.txt"
    local file = io.open(path)
    if not file then return nil end
    local program = file:read("*a"):gsub("\n[^\n]*$", "")
    file:close()
    print(program)
    cb({
        type = 'executable',
        command = vim.g.netcoredbg,
        args = {
            '--interpreter=vscode',
            '--',
            program
        },
        options = {
            detached = false
        },
    })
end

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "netcoredbg",
        request = "launch",
        program = "",
        args = {},
        justMyCode = false,
        stopAtEntry = false,
        console = "integratedTerminal",
        logging = {
            moduleLoad = false,
            processExit = false,
        },
        cwd = function()
            return vim.fn.getcwd()
        end,
    },
}

dap.defaults.coreclr.exception_breakpoints = { 'user-unhandled' }

dap.listeners.before.attach.dapui_config = function()
    ui.open({reset = true})
end

dap.listeners.before.launch.dapui_config = function()
    ui.open({reset = true})
end

dap.listeners.before.event_terminated.dapui_config = function()
    ui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
    ui.close()
end

-- EasyMotion
vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_smartcase = 1
vim.g.EasyMotion_startofline = 0

-- Float preview
vim.g['float_preview#docked'] = 0

-- Gruvbox
vim.g.gruvbox_italic = 1
vim.g.gruvbox_underline = 1
vim.g.gruvbox_undercurl = 1
vim.g.gruvbox_bold = 1
vim.g.gruvbox_italic = 1
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_transparent_bg = 1

-- Neomake

vim.g.neomake_logfile = vim.env.HOME .. '/neomake.log'
vim.g.neomake_open_list = 0
vim.g.neomake_verbose = 1
vim.g["airline#extensions#neomake#enabled"] = 1

vim.g.neomake_restore_maker = {
    exe='make',
    args={'restore'},
    errorformat='%f:%l:%c: %m',
}

vim.cmd([[
    let s:spinner_index = 0
    let s:active_spinners = 0

    " let s:spinner_states = ['|', '/', '--', '\', '|', '/', '--', '\']
    " let s:spinner_states = ['┤', '┘', '┴', '└', '├', '┌', '┬', '┐']
    " let s:spinner_states = ['←', '↑', '→', '↓']
    " let s:spinner_states = ['d', 'q', 'p', 'b']
    " let s:spinner_states = ['.', 'o', 'O', '°', 'O', 'o', '.']
    " let s:spinner_states = ['■', '□', '▪', '▫', '▪', '□', '■']

    let s:spinner_states = ['←', '↖', '↑', '↗', '→', '↘', '↓', '↙']

    function! StartSpinner()
        let b:show_spinner = 1
        let s:active_spinners += 1
        if s:active_spinners == 1
            let s:spinner_timer = timer_start(1000 / len(s:spinner_states), 'SpinSpinner', {'repeat': -1})
        endif
    endfunction

    function! StopSpinner()
        let b:show_spinner = 0
        let s:active_spinners -= 1
        if s:active_spinners == 0
            :call timer_stop(s:spinner_timer)
        endif
    endfunction

    function! SpinSpinner(timer)
        let s:spinner_index = float2nr(fmod(s:spinner_index + 1, len(s:spinner_states)))
        redraw!
    endfunction

    function! SpinnerText()
        if get(b:, 'show_spinner', 0) == 0
            return " "
        endif

        return s:spinner_states[s:spinner_index]
    endfunction

    augroup neomake_hooks
        au!
        autocmd User NeomakeJobInit :call StartSpinner()
        autocmd User NeomakeFinished :call StopSpinner()
    augroup END

    call airline#parts#define_function('neomake','SpinnerText')

    let g:airline_section_x = airline#section#create_right(['coc_current_function', 'bookmark', 'scrollbar', 'tagbar', 'taglist', 'vista', 'gutentags', 'neomake', 'gen_tags', 'omnisharp', 'grepper', 'codeium', 'filetype'])
]])
