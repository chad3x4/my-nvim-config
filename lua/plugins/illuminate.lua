-- Highlight attribute, method,...
return {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" }, -- lazy-load on file open
    opts = {
        delay = 500,
        highlight_under_cursor = false,
        filetypes_denylist = {
            "NvimTree",
            "alpha",
            "dashboard",
            "lazy",
        },
    },
    config = function(_, opts)
        require("illuminate").configure(opts)

        -- change the highlight style
        vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

        --- auto update the highlight style on colorscheme change
        vim.api.nvim_create_autocmd({ "ColorScheme" }, {
            pattern = { "*" },
            callback = function(ev)
                vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
                vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
                vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
            end,
        })
    end,
}
