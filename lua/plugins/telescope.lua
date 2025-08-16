return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                path_display = { "smart" },
            },
        })
        local builtin = require("telescope.builtin")
        local keymap = vim.keymap
        keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
        keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
        keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
        keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
        keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Telescope find recent files" })
        keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find string under cursor in cwd" })

        telescope.load_extension("fzf")
    end,
}
