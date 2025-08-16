-- Show current context at the end of closing tag/bracket/parenthisis/etc
return {
    "code-biscuits/nvim-biscuits",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("nvim-biscuits").setup({
            toggle_keybind = "<leader>bt",
            show_on_start = true,
            cursor_line_only = true,
            default_config = {
                prefix_string = " ⤷ ",
            },
        })
    end,
    keys = {
        {
            "<leader>be",
            function()
                require("nvim-biscuits").BufferAttach()
            end,
            mode = "n",
            desc = "Enable Biscuits",
        },
    },
}
