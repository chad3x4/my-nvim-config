return { -- Floating statuslines
    "b0o/incline.nvim",
    event = "BufReadPre",
    config = function()
        local colors = require("dracula").colors()

        require("incline").setup({
            highlight = {
                groups = {
                    InclineNormal = { guibg = colors.bg, guifg = colors.fg },
                    InclineNormalNC = { guibg = "none", guifg = colors.comment },
                },
            },
            window = { margin = { vertical = 1, horizontal = 2 } },
            hide = { cursorline = "focused_win" },
            render = function(props)
                local function get_diagnostic_label()
                    local icons = { error = "", warn = "", info = "", hint = "" }
                    local label = {}

                    for severity, icon in pairs(icons) do
                        local n = #vim.diagnostic.get(
                            props.buf,
                            { severity = vim.diagnostic.severity[string.upper(severity)] }
                        )
                        if n > 0 then
                            table.insert(label, { icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
                        end
                    end
                    if #label > 0 then
                        table.insert(label, { "┊ " })
                    end
                    return label
                end

                local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                if vim.bo[props.buf].modified then
                    filename = "[+]" .. filename
                end

                local icon, color = require("nvim-web-devicons").get_icon_color(filename)

                return {
                    { get_diagnostic_label(), guibg = "none" },
                    { icon .. " ",            guifg = color },
                    { filename },
                }
            end,
        })
    end,
}
