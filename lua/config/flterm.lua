-- Remap leaving 'terminal mode' to double tap esc
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
    floating = {
        buf = -1,
        win = -1,
    },
}
local api = vim.api

local function open_floating_terminal(opts)
    opts = opts or {}
    local vim_o = vim.o
    local width = opts.width or math.floor(vim_o.columns * 0.8)
    local height = opts.height or math.floor(vim_o.lines * 0.8)

    local row = math.floor((vim_o.lines - height) / 2)
    local col = math.floor((vim_o.columns - width) / 2)

    local buf = nil
    if api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = api.nvim_create_buf(false, true)
    end
    if not buf then
        error("Failed to create buffer")
    end

    local win = api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    return { buf = buf, win = win }
end

local toggle_terminal = function()
    if not api.nvim_win_is_valid(state.floating.win) then
        state.floating = open_floating_terminal({ buf = state.floating.buf })
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
            vim.cmd("startinsert!")
        end
    else
        api.nvim_win_hide(state.floating.win)
    end
end

api.nvim_create_user_command("Flterm", toggle_terminal, {})
api.nvim_set_keymap("n", "<leader>ft", [[:Flterm<CR>]], { noremap = true, silent = true })
