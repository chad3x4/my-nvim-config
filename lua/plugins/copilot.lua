return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        build = "make tiktoken",
        opts = {
            -- See Configuration section for options
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
