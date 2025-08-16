return {
    --    { -- This helps with ssh tunneling and copying to clipboard
    --	'ojroques/vim-oscyank',
    --    },
    { -- Git plugin
        "tpope/vim-fugitive",
    },
    { -- Smooth scroll
        "karb94/neoscroll.nvim",
        opts = {},
    },
    { -- Show CSS Colors
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({})
        end,
    },
    { -- UI for notifications and LSP progress messages
        "j-hui/fidget.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = true,
    },
    { -- Show shortcuts suggestion
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        opts = {},
    },
    { -- Show special position inside scrollbar using gitsigns
        "petertriho/nvim-scrollbar",
        event = "VeryLazy",
        dependencies = {
            "lewis6991/gitsigns.nvim",
        },
        config = function()
            require("scrollbar").setup()
            require("scrollbar.handlers.gitsigns").setup()
        end,
    },
    { -- Smart renaming with immediate visual feedback
        "smjonas/inc-rename.nvim",
        event = "InsertEnter",
        config = function()
            require("inc_rename").setup({
                input_buffer_type = "dressing",
            })
            vim.keymap.set("n", "<leader>rn", ":IncRename ", { desc = "Smart rename" })
        end,
    },
    { -- Floating jumplocation list
        "lewis6991/whatthejump.nvim",
        event = { "BufReadPre", "BufNewFile" },
    },
    { -- Floating statuslines
        "b0o/incline.nvim",
        config = function()
            require("incline").setup()
        end,
        -- Optional: Lazy load Incline
        event = "VeryLazy",
    },
    { -- For navigating between pane for both vim and tmux
        "christoomey/vim-tmux-navigator",
    },
    { -- Multi cursors like vscode
        -- Create cursors vertically Ctrl + Up/Down
        -- Choose a word Ctrl + n
        "mg979/vim-visual-multi",
        event = "InsertEnter",
    },
}
