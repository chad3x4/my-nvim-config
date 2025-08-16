return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            highlight = {
                enable = true,
            },
            indent = { enable = true },
            autotag = { enable = true },
            ensure_installed = {
                "lua",
                "tsx",
                "typescript",
                "javascript",
                "java",
                "dart",
                "json",
                "yaml",
                "html",
                "css",
                "bash",
                "dockerfile",
                "gitignore",
            },
            auto_install = false,
        })
    end,
}
