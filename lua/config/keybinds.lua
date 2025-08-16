vim.g.mapleader = " "
local keymap = vim.keymap

-- Disable because netwr is disabled in nvim-tree setup
-- keymap.set("n", "<leader>cd", vim.cmd.Explore, { desc = "Open file explore" })

-- Go backward: <C-o>, Go forward: <C-i>

-- center screen when looping search results
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- reload without exiting vim
keymap.set("n", "<leader>rl", "<cmd>source ~/.config/nvim/init.lua<cr>")

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-b>", { desc = "Decrement number" })

-- move line
keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- source file
keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, { desc = "Reload Vim script" })
