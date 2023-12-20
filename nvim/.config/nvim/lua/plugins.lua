local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require('lazy').setup({
    { "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function () 
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "cpp", "python", "bash", "lua", "vim", "vimdoc", "fish", "yaml", "markdown", "markdown_inline" },
                highlight = { enable = true },
                indent = { enable = true },  
            })
        end
    },

    { 'mboughaba/i3config.vim', ft = {'i3config'}},

    { "nvimdev/lspsaga.nvim",
        config = function()
            require('lspsaga').setup({})
        end,
        keys = {
            {"gd", "<cmd>Lspsaga peek_definition<CR>"},
            {"gt", "<cmd>Lspsaga peek_type_definition<CR>"},
            {"ga", "<cmd>Lspsaga code_action<CR>"},
            {"gi", "<cmd>Lspsaga incoming_calls<CR>"},
            {"go", "<cmd>Lspsaga outgoing_calls<CR>"},
        }
    },

    { "nvimdev/guard.nvim",
        dependencies = {
            'nvimdev/guard-collection',
        },
        config = function()
            local ft = require('guard.filetype')

            ft('cpp'):fmt('clang-format')
            ft('c'):fmt('clang-format')

            require('guard').setup({
                fmt_on_save = true,
                lsp_as_default_formatter = false,
            })
        end
    },

    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim",        -- optional
            "ibhagwan/fzf-lua",              -- optional
        },
        config = true
    },

    { 'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    },

    { 'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'rose-pine'
        },
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'rose-pine'
                },
                extensions = {'nvim-tree'}
            }
        end
    },

    { 'xiyaowong/nvim-transparent',
        config = function()
            require("transparent").setup({
                extra_groups = {
                    "BufferLineTabClose",
                    "BufferlineBufferSelected",
                    "BufferLineFill",
                    "BufferLineBackground",
                    "BufferLineSeparator",
                    "BufferLineIndicatorSelected",
                },
                exclude_groups = {}, -- table: groups you don't want to clear
            })
        end
    },

    {'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            vim.opt.termguicolors = true
            require("bufferline").setup({
                options = {
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "center",
                            separator = true
                        }
                    },
                }
            })
        end
    },

    { 'nvim-tree/nvim-tree.lua',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            vim.opt.termguicolors = true

            require("nvim-tree").setup({
                view = {
                    preserve_window_proportions = true,
                },
                actions = {
                    open_file = {
                        resize_window = false,
                    },
                },
            })
        end,
        keys = {
            { "<C-k>", "<cmd>NvimTreeToggle<CR>" }
        }
    },

    'vimwiki/vimwiki',

    { "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup() 
        end
    },
    'chaoren/vim-wordmotion',

    { 'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            local theme = require("alpha.themes.startify") --or require("alpha.themes.startify")
            theme.mru_opts.autocd = true
            require'alpha'.setup(theme.config)
        end
    },

    { 'neovim/nvim-lspconfig',
        config = function()
            local lspconfig = require("lspconfig");
            lspconfig.clangd.setup{}
            lspconfig.pylsp.setup{}
            lspconfig.zls.setup{}
            lspconfig.bashls.setup{}
        end
    },

    { 'Shougo/ddc.vim',
        dependencies = {
            'Shougo/ddc-ui-native',
            'vim-denops/denops.vim',
            'Shougo/ddc-source-lsp',
            'Shougo/ddc-source-around',
            'LumaKernel/ddc-source-file',
            'Shougo/ddc-sorter_rank',
            'Shougo/ddc-matcher_head',
        },
        lazy = false,
        config = function()
            require("lspconfig").denols.setup({
                capabilities = require("ddc_source_lsp").make_client_capabilities(),
            })
            vim.fn['ddc#custom#patch_global']('ui', 'native')
            vim.fn['ddc#custom#patch_global']({
                sources = {'lsp', 'around', 'file'},
                sourceOptions = {
                    _ = {
                        matchers = {'matcher_head'},
                        sorters = {'sorter_rank'}
                    },
                    lsp = {
                        mark = 'L',
                        forceCompletionPattern = '\\.\\w*| =\\w*|->\\w*'
                    },
                    around = {
                        mark = 'A'
                    },
                    file = {
                        mark = 'F',
                        isVolatile = true,
                        forceCompletionPattern = '\\S/\\S*'
                    }
                },
                sourceParams = {
                    enableResolveItem = true,
                    enableAdditionalTextEdit = true,
                }
            })
            vim.keymap.set('i', '<Tab>', function()
                local col = vim.fn.col('.') - 1
                if vim.fn.pumvisible() == 1 then
                    return "<C-n>"
                elseif col <= 1 or vim.fn.getline('.'):sub(col, col):match('%s') then
                    return "<TAB>"
                else
                    return vim.cmd("call ddc#map#manual_complete()")
                end
            end, {expr = true, silent = true})

            vim.fn["ddc#enable"]()
        end,
    }
})
