return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer", -- source for text in buffer
        "hrsh7th/cmp-path", -- source for file system paths
        "hrsh7th/cmp-cmdline",
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- follow latest release.
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
        },
        "saadparwaiz1/cmp_luasnip", -- for autocompletion
        "rafamadriz/friendly-snippets", -- useful snippets
        "onsails/lspkind.nvim",   -- vs-code like pictograms
    },
    config = function()
        local cmp = require("cmp")

        local luasnip = require("luasnip")

        local lspkind = require("lspkind")

        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            preselect = "item",
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },
            window = {
                documentation = cmp.config.window.bordered(),
            },
            snippet = { -- configure how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                -- confirm completion item
                ["<CR>"] = cmp.mapping.confirm({ select = false }),

                -- scroll documentation window
                ["<C-f>"] = cmp.mapping.scroll_docs(5),
                ["<C-u>"] = cmp.mapping.scroll_docs(-5),

                -- toggle completion menu
                ["<C-e>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.abort()
                    else
                        cmp.complete()
                    end
                end),

                -- tab complete
                ["<C-j>"] = cmp.mapping(function(fallback)
                    local col = vim.fn.col(".") - 1

                    if cmp.visible() then
                        cmp.select_next_item({ behavior = "select" })
                    elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
                        fallback()
                    else
                        cmp.complete()
                    end
                end, { "i", "s" }),

                -- go to previous item
                ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = "select" }),

                -- navigate to next snippet placeholder
                ["<C-d>"] = cmp.mapping(function(fallback)
                    local luasnip = require("luasnip")

                    if luasnip.jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                -- navigate to the previous snippet placeholder
                ["<C-b>"] = cmp.mapping(function(fallback)
                    local luasnip = require("luasnip")

                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            -- sources for autocompletion
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- snippets
                { name = "buffer" }, -- text within current buffer
                { name = "path" }, -- file system paths
            }),
            formatting = {
                fields = { "abbr", "menu", "kind" },
                format = function(entry, item)
                    local n = entry.source.name
                    if n == "nvim_lsp" then
                        item.menu = "[LSP]"
                    else
                        item.menu = string.format("[%s]", n)
                    end
                    return item
                end,
            },
        })
    end,
}
