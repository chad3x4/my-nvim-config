return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- enable mason and configure icons
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "jdtls",
                "ts_ls",
                "eslint",
                "html",
                "cssls",
                "emmet_ls",
            },
            handlers = {
                -- this first function is the "default handler"
                -- it applies to every language server without a custom handler
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,

                -- this is the "custom handler" for `lua_ls`
                lua_ls = function()
                    require("lspconfig").lua_ls.setup({
                        settings = {
                            Lua = {
                                runtime = {
                                    version = "LuaJIT",
                                },
                                diagnostics = {
                                    globals = { "vim" },
                                },
                                workspace = {
                                    library = { vim.env.VIMRUNTIME },
                                    -- library = vim.api.nvim_get_runtime_file("", true),
                                },
                            },
                        },
                    })
                end,
            },
        })
        require("mason-tool-installer").setup({
            ensure_installed = {
                "prettier",
                "stylua",
                "google-java-format",
            },
        })
    end,
}
