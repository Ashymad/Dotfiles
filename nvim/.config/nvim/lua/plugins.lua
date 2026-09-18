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
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function () 
            require('nvim-treesitter').install { "c", "cpp", "python", "bash", "lua", "vim", "vimdoc", "fish", "yaml", "markdown", "markdown_inline", "zig" }
            vim.api.nvim_create_autocmd('FileType', {
                pattern = { "c", "cpp", "python", "bash", "lua", "vim", "vimdoc", "fish", "yaml", "markdown", "zig" },
                callback = function() vim.treesitter.start() end,
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
                },
            },

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
            "MunifTanjim/nui.nvim",
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
                            filetype = "neo-tree",
                            text = "File Explorer",
                            text_align = "center",
                            separator = true
                        }
                    },
                }
            })
        end
    },

    { "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            { "<C-s>", "<cmd>Neotree<CR>" }
        }
    },

    { "Crysthamus/nvim-file-operations",
        -- branch = "compat" -- if you are on Neovim <= 0.10
        dependencies = {
            "nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
        },
        config = function()
            require("nvim-file-operations").setup()
        end,
    },

    { "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
            require("window-picker").setup({
                filter_rules = {
                    include_current_win = false,
                    autoselect_one = true,
                    -- filter using buffer options
                    bo = {
                        -- if the file type is one of following, the window will be ignored
                        filetype = { "neo-tree", "neo-tree-popup", "notify" },
                        -- if the buffer type is one of following, the window will be ignored
                        buftype = { "terminal", "quickfix" },
                    },
                },
            })
        end,
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
                c = {"clang-format"},
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
                        vim.lsp.enable(srv) 
                    end
                end
            end
            lsp_enable({'clangd', 'pylsp', 'zls', 'bashls', 'artaclsp', 'beancount'})
        end
    },

    { 'vim-denops/denops.vim',
        init = function()
            if 1 ~= vim.fn.executable("deno") then
                vim.g["denops#deno"] = "podman"
            end
        end,
        config = function()
            if vim.g["denops#deno"] == "podman" then
                vim.g["denops#server#deno_args"] = {
                   "-v", vim.env.HOME .. ":" .. vim.env.HOME,
                   "-e", "DENO_DIR=" .. vim.env.HOME .. "/.cache/deno", 
                   "--rm",
                   "--network=host",
                   "ghcr.io/denoland/deno:distroless",
                   "run",
                   unpack(vim.g["denops#server#deno_args"])
                }
            end
        end
    },

    { 'Shougo/ddc.vim',
        dependencies = {
            'vim-denops/denops.vim',
            'Shougo/pum.vim',
            'Shougo/ddc-ui-pum',
            'Shougo/ddc-source-lsp',
            'Shougo/ddc-source-around',
            'Shougo/ddc-sorter_rank',
            'Shougo/ddc-matcher_head',
            'LumaKernel/ddc-source-file',
        },
        lazy = false,
        config = function()
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
