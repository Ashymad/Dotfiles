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

    { "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        config = function()
            require("tiny-inline-diagnostic").setup({
                options = {
                    overwrite_events = {"DiagnosticChanged"},
                    multilines = {
                        enabled = true,
                        always_show = false,
                    },
                },
            })
            vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
        end,
    },

    { 'mboughaba/i3config.vim', ft = {'i3config'}},

    { "aserowy/tmux.nvim",
        config = function() return require("tmux").setup() end
    },

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

    { "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },

            cmdline = {
                view = "cmdline",
            },
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },

    { 'tac',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        enabled = function()
            return vim.fn.isdirectory('/src/ArEditorPlugins/nvim/plugins/tac.nvim') ~= 0
        end,
        dir = '/src/ArEditorPlugins/nvim/plugins/tac.nvim',
        config = function()
            require('tac').setup()
        end
    },

    { "mfussenegger/nvim-lint",
        event = 'VeryLazy',
        priority = '500',
        config = function()
            require('lint').linters_by_ft = {
                python = {'pylint'},
            }

            vim.api.nvim_create_autocmd({"TextChanged"}, {
                callback = function()
                    require("lint").try_lint()
                end
            })
        end
    },

    { "ibhagwan/fzf-lua",
        keys = {
            {"<c-P>", "<cmd>FzfLua files<CR>"},
            {"gs", "<cmd>FzfLua grep_cword<CR>"},
            {"gs", "<cmd>FzfLua grep_visual<CR>", mode="x"},
        }
    },

    { "NeogitOrg/neogit",
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
        dependencies = {
            'akinsho/bufferline.nvim',
            'nvim-lualine/lualine.nvim'
        },
        config = function()
            require("transparent").setup({})
            require('transparent').clear_prefix('BufferLine')
            require 'transparent'.clear_prefix("TabLine")
        end
    },

    { 'mcauley-penney/visual-whitespace.nvim',
        config = true,
        event = "ModeChanged *:[vV\22]", -- optionally, lazy load on entering visual mode
        opts = {},
    },

    { 'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        lazy = false,
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
        end
    },

    { "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup() 
        end
    },

    'chaoren/vim-wordmotion',

    'janet-lang/janet.vim',

    { 'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            local theme = require("alpha.themes.startify") --or require("alpha.themes.startify")
            theme.mru_opts.autocd = true
            require'alpha'.setup(theme.config)
        end
    },

    { 'stevearc/conform.nvim',
        dependencies = { 'lewis6991/gitsigns.nvim' },
        opts = {
            formatters_by_ft = {
                cpp = {"clang-format"},
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            formatters = {}
        }
    },

    { 'neovim/nvim-lspconfig',
        lazy = false,
        config = function()
            vim.lsp.config.artaclsp = {
                cmd = { 'artaclsp' },
                root_dir = '/src',
                filetypes = { 'tac' },
            }
            lsp_enable = function(srvs)
                for i,srv in ipairs(srvs) do
                    if 1 == vim.fn.executable(vim.lsp.config[srv].cmd[1]) then
                      --  vim.lsp.config(srv, coq.lsp_ensure_capabilities())
                        vim.lsp.enable(srv) 
                    end
                end
            end
            lsp_enable({'clangd', 'pylsp', 'zls', 'bashls', 'artaclsp', 'beancount'})
        end
    },

    { 'Shougo/ddc.vim',
        dependencies = {
            'Shougo/pum.vim',
            'Shougo/ddc-ui-pum',
            { 'vim-denops/denops.vim', branch = 'fallback_version' },
            'Shougo/ddc-source-lsp',
            'Shougo/ddc-source-around',
            'LumaKernel/ddc-source-file',
            'Shougo/ddc-sorter_rank',
            'Shougo/ddc-matcher_head',
        },
        lazy = false,
        config = function()
            vim.g["denops#deno"] = "podman"
            vim.g["denops#server#deno_args"] = {
                "-v", vim.env.HOME .. ":" .. vim.env.HOME,
                "-e", "DENO_DIR=" .. vim.env.HOME .. "/.cache/deno", 
                "--network=host",
                "ghcr.io/denoland/deno:distroless",
                "run",
                unpack(vim.g["denops#server#deno_args"])
            }
            vim.lsp.config('denols', {
                capabilities = require("ddc_source_lsp").make_client_capabilities(),
            })
            vim.lsp.enable('denols')
            vim.fn['ddc#custom#patch_global']('ui', 'pum')
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
            vim.fn["ddc#enable"]()
        end,
    }
})
