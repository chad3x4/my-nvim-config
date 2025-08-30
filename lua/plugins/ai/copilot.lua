return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        build = "make tiktoken",
        opts = {
            window = {
                layout = "float",
                title = "  Copilot in  Neovim",
                width = 0.8,
                height = 0.8,
                border = "rounded",
                zindex = 100,
                blend = 5,
            },

            headers = {
                user = " You: ",
                assistant = " Copilot: ",
                tool = "󰖷 Tool: ",
            },
            separator = "━━",
            show_folds = false, -- Disable folding for cleaner look
        },
        keys = {
            { "<leader>cc", "<cmd>CopilotChatToggle<cr>",   mode = "n", desc = "Toggle Copilot Chat" },
            { "<leader>ce", "<cmd>CopilotChatExplain<cr>",  mode = "v", desc = "Explain Code" },
            { "<leader>cr", "<cmd>CopilotChatReview<cr>",   mode = "v", desc = "Review Code" },
            { "<leader>cf", "<cmd>CopilotChatFix<cr>",      mode = "v", desc = "Fix Code Issues" },
            { "<leader>co", "<cmd>CopilotChatOptimize<cr>", mode = "v", desc = "Optimize Code" },
            { "<leader>cd", "<cmd>CopilotChatDocs<cr>",     mode = "v", desc = "Generate Docs" },
            { "<leader>ct", "<cmd>CopilotChatTests<cr>",    mode = "v", desc = "Generate Tests" },
            { "<leader>cm", "<cmd>CopilotChatCommit<cr>",   mode = "n", desc = "Generate Commit Messages" },
            { "<leader>cs", "<cmd>CopilotChatCommit<cr>",   mode = "v", desc = "Generate Commit for Selection" },
            { "<leader>cx", "<cmd>CopilotChatReset<cr>",    mode = "n", desc = "Reset Copilot Chat" },
        },
    },
}
