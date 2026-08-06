local dotnet_analyzer = "roslyn" -- "roslyn" | "csharp_ls"
local completion_engine = "nvim-cmp" -- "nvim-cmp" | "coq_nvim"

vim.pack.add({
    'https://github.com/kmiterror/dotnet-debug.nvim',
    'https://github.com/ellisonleao/gruvbox.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lualine/lualine.nvim',
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

if dotnet_analyzer == "roslyn" then
    vim.pack.add({'https://github.com/seblyng/roslyn.nvim'})
end

if completion_engine == "nvim-cmp" then
    vim.pack.add({
        'https://github.com/hrsh7th/cmp-nvim-lsp',
        'https://github.com/hrsh7th/cmp-buffer',
        'https://github.com/hrsh7th/cmp-path',
        'https://github.com/hrsh7th/nvim-cmp',
        'https://github.com/onsails/lspkind.nvim',
    })
elseif completion_engine == "coq_nvim" then
    vim.pack.add({
        { src='https://github.com/ms-jpq/coq_nvim', version='coq' },
        { src='https://github.com/ms-jpq/coq.artifacts', version='artifacts' },
        { src='https://github.com/ms-jpq/coq.thirdparty', version='3p' },
    })
end


-- Lualine


-- FZF
vim.g.fzf_action = { ['ctrl-x']='split', ['ctrl-v']='vsplit' }

-- Vista
vim.g.vista_executive_for = { xml='nvim_lsp', razor='nvim_lsp', cs='nvim_lsp', rs='nvim_lsp', css='nvim_lsp', sass='nvim_lsp', less='nvim_lsp' }

-- Completion
local completion
local config_lsp

if completion_engine == "coq_nvim" then
    completion = require("coq")

    vim.g.coq_settings = {
        limits={ idle_timeout=0.1, },
        clients={
            ['lsp.resolve_timeout'] = 4.5,
            ['lsp.always_on_top']={},
            ['buffers.weight_adjust']=-2.0,
            ['lsp.weight_adjust']=2.0,

            ["tmux.enabled"]=false,
            ["treesitter.enabled"]=false,
            ["tags.enabled"]=false,
            ["registers.enabled"]=false,
            -- ['buffers.enabled']=false,
        },
    }

    config_lsp = function (server, config)
        vim.lsp.config(server, config)
    end
elseif completion_engine == "nvim-cmp" then
    completion = require("cmp")
    local lspkind = require("lspkind")

    local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end

    completion.setup({
        snippet = {
            expand = function(args) vim.snippet.expand(args.body) end
        },
        window = {
            completion = completion.config.window.bordered(),
            documentation = completion.config.window.bordered(),
        },
        mapping = completion.mapping.preset.insert({
            ['<C-b>'] = completion.mapping.scroll_docs(-4),
            ['<C-f>'] = completion.mapping.scroll_docs(4),
            ['<C-Space>'] = completion.mapping.complete(),
            ['<Esc>'] = completion.mapping.abort(),
            ['<CR>'] = completion.mapping.confirm({ select = true }),
            ['<Tab>'] = function (fallback)
                if not completion.select_next_item() then
                    if vim.bo.buftype ~= 'prompt' and has_words_before() then
                        completion.complete()
                    else
                        fallback()
                    end
                end
            end,
            ['<S-Tab>'] = function (fallback)
                if not completion.select_prev_item() then
                    if vim.bo.buftype ~= 'prompt' and has_words_before() then
                        completion.complete()
                    else
                        fallback()
                    end
                end
            end,
            ['<C-Tab>'] = completion.mapping.confirm({
                behavior = completion.ConfirmBehavior.Insert,
                select = true,
            })
        }),
        sources = completion.config.sources({
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'path' },
        }),
        formatting = {
            format = lspkind.cmp_format({
                mode = "symbol_text",
                menu = ({
                    buffer = "[BUF]",
                    nvim_lsp = "[LSP]",
                    path = "[PTH]",
                })
            }),
        },
        view = {
            entries = "custom"
        },
    })

    config_lsp = function (server, config)
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        config["capabilities"] = capabilities

        vim.lsp.enable(server, config)
    end
end

vim.diagnostic.config({
    signs = { severity = { min = vim.diagnostic.severity.WARN } },
    underline = { severity = { min = vim.diagnostic.severity.HINT } },
})


if dotnet_analyzer == "csharp_ls" then
    config_lsp('csharp_ls', {
        cmd = { vim.g.csharpls_path, "-l", "info" },
        filetypes = { "cs", "razor", "xml" },
        enable_editorconfig_support = true,
        enable_ms_build_load_projects_on_demand = true,
        enable_roslyn_analyzers = true,
        organize_imports_on_format = true,
        enable_import_completion = true,
        sdk_include_prereleases = true,
        analyze_open_documents_only = false,
        settings = {
            csharp = {
                useMetadataUris = true,
                razorSupport = true,
            },
        },
        root_dir =
            vim.fs.root(
                0,
                function (name, path)
                    return name:match('%.slnx?$') ~= nil
                end
            ),
    })
elseif dotnet_analyzer == "roslyn" then
    config_lsp('roslyn', {
        filetypes = { "cs", "razor", "xml" },
        enable_editorconfig_support = true,
        enable_ms_build_load_projects_on_demand = true,
        enable_roslyn_analyzers = true,
        organize_imports_on_format = true,
        enable_import_completion = true,
        sdk_include_prereleases = true,
        analyze_open_documents_only = false,
        root_dir = vim.fs.root(
            0,
            function (name, path)
                return name:match('%.slnx?$') ~= nil
            end
        ),
        settings = {
            -- ['csharp|background_analysis'] = {
            --     dotnet_analyzer_diagnostics_scope = 'fullSolution',
            --     dotnet_compiler_diagnostics_scope = 'fullSolution',
            -- },
            ['csharp|completion'] = {
                dotnet_provide_regex_completions = true,
                dotnet_show_completion_items_from_unimported_namespaces = true,
                dotnet_show_name_completion_suggestions = true,
            },
            ['csharp|symbol_search'] = {
                dotnet_search_reference_assemblies = true,
            },
            ['csharp|formatting'] = {
                dotnet_organize_imports_on_format = true,
            }
        }
    })
end

config_lsp('rust_analyzer', {
    ['rust_analyzer'] = { diagnostics = { enable = true } },
})

config_lsp('tailwindcss', {
    filetypes = { 'css', 'less', 'sass' },
    workspace_required = false,
})

config_lsp('html', {
    filetypes = { 'html', 'razor' }
})

local csls_ext = require("csharpls_extended")

csls_ext.buf_read_cmd_bind()

require('lsp-overloads').setup({
    ui = { border = "rounded" },
    keymaps = { close_signature = "<esc>" },
    display_automatically = false
})

if completion_engine == "coq_nvim" then
    completion.setup()
end

vim.lsp.enable('rust_analyzer')

if dotnet_analyzer == "csharp_ls" then
    vim.lsp.enable('csharp_ls')
elseif dotnet_analyzer == "roslyn" then
    vim.lsp.enable('roslyn')
end

vim.lsp.enable('lua_ls')
vim.lsp.enable('html')
vim.lsp.enable('tailwindcss')

-- DAP

local dap = require("dap")
local ui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")

dap_virtual_text.setup()

ui.setup()

vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

if vim.g.dotnet_debugger == "netcoredbg" then
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
elseif vim.g.dotnet_debugger == "vsdbg" then
    local signer_path = vim.env.HOME .. "/AppData/Local/Programs/Microsoft VS Code/e4c7e7b1d6/resources/app/node_modules.asar.unpacked/vsda/build/Release/vsda.node"
    local debugger_path = vim.env.HOME .. "/.vscode/extensions/ms-dotnettools.csharp-2.147.94-win32-x64/.debugger/x86_64/vsdbg-ui.exe"

    require("dotnet-debug").setup({
        signer_path = signer_path,
        debugger_path = debugger_path,
    })
end

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

require('gruvbox').setup({
    terminal_colors = true,
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = true,
        folds = false,
    },
    strikethrough = true,
    transparent_mode = true,
})

local spinner_index = 0
-- local spinner_states = ['|', '/', '--', '\', '|', '/', '--', '\']
-- local spinner_states = ['┤', '┘', '┴', '└', '├', '┌', '┬', '┐']
-- local spinner_states = ['←', '↑', '→', '↓']
-- local spinner_states = ['d', 'q', 'p', 'b']
-- local spinner_states = ['.', 'o', 'O', '°', 'O', 'o', '.']
-- local spinner_states = ['■', '□', '▪', '▫', '▪', '□', '■']
local spinner_states = {'←', '↖', '↑', '↗', '→', '↘', '↓', '↙'}
local active_spinners = 0
local timer = nil

local function spin_spinner()
    spinner_index = (spinner_index + 1) % #spinner_states
    vim.api.nvim__redraw({statusline = true})
end

local function start_spinner()
    vim.b.show_spinner = true
    active_spinners = active_spinners + 1

    if active_spinners == 1 then
        timer = vim.loop.new_timer()
        timer:start(0, 1000, vim.schedule_wrap(spin_spinner))
    end
end

local function stop_spinner()
    vim.b.show_spinner = false
    active_spinners = active_spinners - 1

    if active_spinners == 0 then
        timer:close()
        timer = nil
    end
end

local function neomake_spinner()
    if not vim.b.show_spinner then
        return ""
    end

    return spinner_states[spinner_index]
end

local neomake_hooks = vim.api.nvim_create_augroup("neomake_hooks", {clear=true})

vim.api.nvim_create_autocmd("User", {
    pattern = "NeomakeJobInit",
    group = neomake_hooks,
    callback = start_spinner,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "NeomakeFinished",
    group = neomake_hooks,
    callback = stop_spinner,
})

vim.api.nvim_create_autocmd('BufReadPost', {
    pattern = 'quickfix',
    callback = function ()
        vim.keymap.set('n', '<cr>', '<cr>', { buf = 0 })
    end
})


local lualine = require('lualine')

lualine.setup({
    options = {
        icons_enabled = false,
        always_show_tabline = true,
        globalstatus = true,
    },
    tabline = {
        lualine_a = {
            {
                'buffers',
                show_filename_only = false,
            }
        },
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {neomake_spinner, 'progress'},
        lualine_z = {'location'}
    },
})

