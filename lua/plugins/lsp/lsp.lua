return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim",                   opts = {} },
    },
    config = function()
        local keymap = vim.keymap -- for conciseness
        local api = vim.api
        local lsp = vim.lsp
        local diagnostic = vim.diagnostic

        local autoformat_filetypes = {
            "lua",
        }
        -- Create a keymap for vim.lsp.buf.implementation
        api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = lsp.get_client_by_id(args.data.client_id)
                if not client then
                    return
                end
                if vim.tbl_contains(autoformat_filetypes, vim.bo.filetype) then
                    api.nvim_create_autocmd("BufWritePre", {
                        buffer = args.buf,
                        callback = function()
                            lsp.buf.format({
                                formatting_options = { tabSize = 4, insertSpaces = true },
                                bufnr = args.buf,
                                id = client.id,
                            })
                        end,
                    })
                end
            end,
        })

        local cmp = require("cmp")

        -- cmdline setup.
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- cmdline setup.
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                {
                    name = "cmdline",
                    option = {
                        ignore_cmds = { "Man", "!" },
                    },
                },
            }),
        })

        -- Add borders to floating windows
        lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = "rounded" })
        lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, { border = "rounded" })

        -- Configure error/warnings interface
        diagnostic.config({
            virtual_text = true,
            severity_sort = true,
            float = {
                style = "minimal",
                border = "rounded",
                header = "",
                prefix = "",
            },
            signs = {
                text = {
                    [diagnostic.severity.ERROR] = "",
                    [diagnostic.severity.WARN] = "",
                    [diagnostic.severity.HINT] = "󰠠",
                    [diagnostic.severity.INFO] = "",
                },
            },
        })

        -- This is where you enable features that only work
        -- if there is a language server active in the file
        api.nvim_create_autocmd("LspAttach", {
            callback = function(event)
                keymap.set("n", "K", lsp.buf.hover, { desc = "Show documentation" })
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Show definitions" })
                keymap.set("n", "gD", lsp.buf.definition, { desc = "Go to declaration" })
                keymap.set("n", "gi", lsp.buf.implementation, { desc = "Show implementations" })
                keymap.set("n", "go", lsp.buf.type_definition, { desc = "Show type definitions" })
                keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "Go to references" })
                keymap.set("n", "gR", "<cmd>Telescope lsp_implementations<cr>", { desc = "Show implementations" })
                keymap.set("n", "gs", lsp.buf.signature_help, { desc = "Show help for signature" })
                keymap.set("n", "gl", diagnostic.open_float, { desc = "Show diagnostic" })
                keymap.set(
                    { "n", "x" },
                    "<leader>rf",
                    "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
                    { desc = "Reformat code" }
                )
                keymap.set("n", "<leader>ca", lsp.buf.code_action, { desc = "See available code actions" })
            end,
        })

        -- Change the Diagnostic symbols in the sign column (gutter)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        vim.opt.completeopt = { "menu", "menuone", "noselect" }

        require("lspconfig").dartls.setup({})

        -- -- Format Dart files on save using `dart format` CLI
        -- vim.api.nvim_create_autocmd("BufWritePost", {
        --     pattern = "*.dart",
        --     callback = function()
        --         local file = vim.fn.expand("%:p")
        --         vim.cmd('silent !dart format "' .. file .. '"')
        --         vim.cmd("edit") -- reload file to reflect formatting
        --     end,
        -- })
    end,
}
