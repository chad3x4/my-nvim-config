-- Show special position inside scrollbar using gitsigns
return {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    dependencies = {
        "lewis6991/gitsigns.nvim",
    },
    config = function()
        require("scrollbar").setup({
            handle = {
                color = "#808080",
            },
            marks = {
                Cursor = {
                    text = "•",
                },
                Search = {
                    text = { "-", "=" },
                    color = "#ffb86c",
                },
                Error = {
                    text = { "-", "=" },
                    color = "#ff5555",
                },
                Warn = {
                    text = { "-", "=" },
                    color = "#f1fa8c",
                },
                Info = {
                    text = { "-", "=" },
                    color = "#50fa7b",
                },
                Hint = {
                    text = { "-", "=" },
                    color = "#8be9fd",
                },
                Misc = {
                    text = { "-", "=" },
                    color = "#bd93f9",
                },
                GitAdd = {
                    text = "▎",
                },
                GitChange = {
                    text = "▎",
                },
                GitDelete = {
                    text = "▁",
                },
            },
        })
        require("scrollbar.handlers.gitsigns").setup()
    end,
}
