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

    use { 'burnettk/vim-jenkins',
        ft = {'Jenkinsfile'},
        config = function()
            vim.g.jenkins_url = 'http://krk-sb13-19.soc-mgt.krk-lab.nsn-rdnet.net:8080'
            vim.g.jenkins_username = 'admin'
            vim.g.jenkins_password = 'egenrules'
        end
    }

    use { "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require('lspsaga').setup({})
            vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
            vim.keymap.set({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
            vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })
            vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
            vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
            vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
            vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
            vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
            vim.keymap.set("n", "[E", function()
                require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
            end, { silent = true })
            vim.keymap.set("n", "]E", function()
                require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
            end, { silent = true })
            vim.keymap.set("n","<leader>o", "<cmd>LSoutlineToggle<CR>",{ silent = true })
            vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
            vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
            vim.keymap.set("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
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
                }
            })

            vim.keymap.set("n", "<C-k>", ":NvimTreeToggle<CR>")
        end
    }

    use 'godlygeek/tabular'

    use { "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                char = "⸾",
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
            })
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
        config = function()
            require'lspconfig'.clangd.setup{}
            require'lspconfig'.zls.setup{}
        end
    }

    use { 'Shougo/ddc-source-nvim-lsp',
        requires = {'Shougo/ddc.vim', 'neovim/nvim-lspconfig'}
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
