-- Show special position inside scrollbar using gitsigns
return {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    dependencies = {
        "lewis6991/gitsigns.nvim",
    },
    config = function()
        require("scrollbar").setup()
        require("scrollbar.handlers.gitsigns").setup()
    end,
}
