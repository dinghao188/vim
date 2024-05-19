return {
    {
        'folke/which-key.nvim',
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
    },
    {
        'folke/tokyonight.nvim',
        priority = 1000,
        config = function()
            require('tokyonight').setup()
            vim.cmd([[ colorscheme tokyonight ]])
        end
    },
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true
    },
    {
        'ibhagwan/fzf-lua',
        cmd = 'FzfLua',
        config = function()
            print('fzf-lua loaded')
        end
    },
    {
        'nvim-tree/nvim-tree.lua',
        cmd = 'NvimTreeToggle',
        opts = {}
    },
    {
        'hrsh7th/nvim-cmp',
        event = { 'InsertEnter', 'CmdlineEnter' },
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
            'neovim/nvim-lspconfig'
        },
        config = function()
            local cmp = require('cmp')
            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local feedkey = function(key, mode)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
            end
            --basic
            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered()
                },
                completion = {
                    keyword_length = 2,
                },
                snippet = {
                    expand = function(args)
                        vim.fn['vsnip#anonymous'](args.body)
                    end
                },
                mapping = {
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            local entries = cmp.get_entries()
                            if #entries == 1 then
                                cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
                                cmp.confirm()
                            elseif not cmp.get_selected_entry() then
                                cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
                            else
                                cmp.confirm()
                            end
                        elseif vim.fn['vsnip#available'](1) == 1 then
                            feedkey("<Plug>(vsnip-expand-or-jump)", "")
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-j>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
                        else
                            fallback()
                        end
                    end),
                    ['<C-k>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
                        else
                            fallback()
                        end
                    end),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' },
                    { name = 'path' },
                    { name = 'buffer' },
                }, {name = 'buffer'}),
                formatting = {
                    format = function(_, item)
                        local icons = {}
                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. item.kind
                        end
                        return item
                    end
                }
            })

            --cmdline
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                mathing = { disallow_symbol_nonprefix_matching = true },
                sources = cmp.config.sources({
                    {name = 'path'},
                    {name = 'cmdline'}
                }, {name = 'cmdline'}),
            })

            --lsp
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            require('lspconfig').clangd.setup {
                capabilities = capabilities
            }
        end
    }
}
