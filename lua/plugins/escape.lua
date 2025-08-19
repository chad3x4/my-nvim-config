return { -- Escape insert & visual mode using "jk"
    "max397574/better-escape.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("better_escape").setup({
            timeout = vim.o.timeoutlen,
            default_mappings = false,
            mappings = {
                i = {
                    j = {
                        k = "<Esc>",
                    },
                },
                v = {
                    j = {
                        k = "<Esc>",
                    },
                },
            },
        })
    end,
}
