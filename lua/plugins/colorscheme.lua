local function enable_transparency()
    local api = vim.api
    api.nvim_set_hl(0, "Normal", { bg = "none" })
    api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
    api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
    api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })
end
return {
    {
        "Mofiqul/dracula.nvim",
        config = function()
            vim.cmd.colorscheme("dracula")
            enable_transparency()
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            theme = "dracula",
        },
        config = function()
            local lualine = require("lualine")
            local lazy_status = require("lazy.status")

            lualine.setup({
                options = {
                    theme = "dracula-nvim",
                },
                sections = {
                    lualine_x = {
                        {
                            lazy_status.updates,
                            cond = lazy_status.has_updates,
                            color = { fg = "#ff9e64" },
                        },
                        { "encoding" },
                        { "fileformat" },
                        { "filetype" },
                    },
                },
            })
        end,
    },
}
