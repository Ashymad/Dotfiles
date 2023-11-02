require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require'nvim-treesitter.configs'.setup({
                highlight = { enable = true },
                incremental_selection = { enable = true },
                textobjects = { enable = true },
            })
        end
    }

    use { 'dag/vim-fish', ft = {'fish'}}

    use { 'mboughaba/i3config.vim', ft = {'i3config'}}

    use { 'stephpy/vim-yaml', rtp = 'after', ft = {'yaml'}}

    use { "nvimdev/lspsaga.nvim",
        config = function()
            require('lspsaga').setup({})
            vim.keymap.set("n", "gd", ":Lspsaga peek_definition<CR>")
            vim.keymap.set("n", "gt", ":Lspsaga peek_type_definition<CR>")
            vim.keymap.set("n", "ga", ":Lspsaga code_action<CR>")
            vim.keymap.set("n", "gi", ":Lspsaga incoming_calls<CR>")
            vim.keymap.set("n", "go", ":Lspsaga outgoing_calls<CR>")
        end
    }

    use { "nvimdev/guard.nvim",
        requires = {
            'nvimdev/guard-collection',
        },
        config = function()
            local ft = require('guard.filetype')

            ft('cpp'):fmt({
                cmd = '/opt/clang/latest/bin/clang-format',
                stdin = true,
            })
            ft('c'):fmt('clang-format')

            require('guard').setup({
                -- the only options for the setup function
                fmt_on_save = true,
                -- Use lsp if no formatter was defined for this filetype
                lsp_as_default_formatter = false,
            })
        end
    }

    use { 'rose-pine/neovim',
     as = 'rose-pine',
     config = function()
         vim.cmd('colorscheme rose-pine')
     end
    }

    use { 'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
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
    }

    use { 'xiyaowong/nvim-transparent',
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
    }

    use {'akinsho/bufferline.nvim',
        requires = 'nvim-tree/nvim-web-devicons',
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
    }

    use { 'nvim-tree/nvim-tree.lua',
        requires = 'nvim-tree/nvim-web-devicons',
        tag = 'nightly',
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

            vim.keymap.set("n", "<C-k>", ":NvimTreeToggle<CR>")
        end
    }

    use 'vimwiki/vimwiki'

    use 'godlygeek/tabular'

    use { "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup() 
        end
    }
    use 'chaoren/vim-wordmotion'

    use { 'goolord/alpha-nvim',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            local theme = require("alpha.themes.startify") --or require("alpha.themes.startify")
            theme.mru_opts.autocd = true
            require'alpha'.setup(theme.config)
        end
    }

    use { 'neovim/nvim-lspconfig',
        requires = { 'creativenull/efmls-configs-nvim' },
        config = function()
            local lspconfig = require("lspconfig");
            lspconfig.clangd.setup{
                cmd = { "/opt/clang/latest/bin/clangd" },
            }
            lspconfig.pylsp.setup{}
            lspconfig.zls.setup{}
            lspconfig.bashls.setup{}
        end
    }

    use { 'Shougo/ddc-source-nvim-lsp',
        requires = {'Shougo/ddc.vim', 'neovim/nvim-lspconfig'}
    }
    use { 'vim-denops/denops.vim',
        config = function()
            -- vim.g.denops_server_addr = '127.0.0.1:32123'
        end
    }

    use { 'Shougo/ddc.vim',
        requires = {
            'Shougo/ddc-ui-native',
            'vim-denops/denops.vim',
            'Shougo/ddc-source-nvim-lsp',
            'Shougo/ddc-sorter_rank',
            'Shougo/ddc-matcher_head'
        },
        config = function()
            vim.fn['ddc#custom#patch_global']('ui', 'native')
            vim.fn['ddc#custom#patch_global']({
                sources = {'nvim-lsp'},
                sourceOptions = {
                    _ = {
                        matchers = {'matcher_head'},
                        sorters = {'sorter_rank'}
                    },
                    ["nvim-lsp"] = {
                        mark = 'L',
                        forceCompletionPattern = '\\.\\w*| =\\w*|->\\w*' },
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
        end
    }

end)
