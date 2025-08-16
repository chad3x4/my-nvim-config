local conditions = require("heirline.conditions")

local Padding = function(n)
    return { provider = string.rep(" ", n) }
end

local Mode = function(icon)
    return {
        init = function(self)
            self.mode = vim.fn.mode(1)

            if not self.once then
                vim.api.nvim_create_autocmd("ModeChanged", { pattern = "*:*o", command = "redrawstatus" })
                self.once = true
            end
        end,
        static = {
            mode_colors = {
                n = "#C3E88D",
                i = "#82AAFF",
                v = "#C792EA",
                ["␖"] = "#C792EA",
                V = "#C792EA",
                c = "#FFCB6B",
                no = "#E06C75",
                s = "#FFCB6B",
                S = "#FFCB6B",
                ["␓"] = "#FFCB6B",
                ic = "#FFE082",
                R = "#E06C75",
                Rv = "#E06C75",
                cv = "#E06C75",
                ce = "#E06C75",
                r = "#E06C75",
                rm = "#E06C75",
                ["r?"] = "#89ddff",
                ["!"] = "#E06C75",
                t = "#FFE082",
            },
        },
        provider = function()
            return icon
        end,
        hl = function(self)
            return { fg = self.mode_colors[self.mode] }
        end,
        update = { "ModeChanged" },
    }
end

local FileSize = {
    provider = function()
        local suffix = { "b", "k", "M", "G", "T", "P", "E" }
        local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
        fsize = (fsize < 0 and 0) or fsize
        if fsize < 1024 then
            return fsize .. suffix[1]
        end
        local i = math.floor((math.log(fsize) / math.log(1024)))

        return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
    end,
}

local FileLines = {
    provider = "%4L",
}

local FileIcon = {
    init = function(self)
        local filename = vim.api.nvim_buf_get_name(0)
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color =
            require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end,
}

local FilePath = {
    provider = function()
        local filepath = vim.fn.expand("%:.")

        if filepath == "" then
            return "[No Name]"
        end

        if not conditions.width_percent_below(#filepath, 0.25) then
            filepath = vim.fn.pathshorten(filepath)
        end

        return filepath
    end,
    hl = function()
        if vim.bo.modified then
            return { fg = "#E06C75", force = true, bold = false }
        else
            return { fg = "#C792EA" }
        end
    end,
}

local FileFlags = {
    {
        condition = function()
            return vim.bo.binary
        end,
        provider = "  ",
        hl = { fg = "#82AAFF" },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = "  ",
        hl = { fg = "#FFCB6B" },
    },
}

local Ruler = {
    provider = "%5(%3l:%-2c%)",
}

local ScrollBar = {
    static = {
        sbar = { "🭶", "🭷", "🭸", "🭹", "🭺", "🭻" },
    },
    provider = function(self)
        local i = math.floor((vim.fn.line(".") - 1) / vim.fn.line("$") * #self.sbar) + 1

        return string.rep(self.sbar[i], 2)
    end,
    hl = { fg = "#82AAFF", bg = "#363a4e" },
}

local Diagnostics = {
    condition = conditions.has_diagnostics,
    static = {
        error_icon = " ",
        warn_icon = " ",
        info_icon = " ",
        hint_icon = " ",
    },
    init = function(self)
        local function count(severity)
            return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[severity] })
        end

        self.errors = count("ERROR")
        self.warnings = count("WARN")
        self.hints = count("HINT")
        self.info = count("INFO")
    end,
    update = { "DiagnosticChanged", "BufEnter" },
    {
        {
            provider = function(self)
                return self.error_icon
            end,
            hl = { fg = "#b5585f" },
        },
        {
            provider = function(self)
                return self.errors .. "  "
            end,
            hl = { fg = "#E06C75", bold = true },
        },
    },
    {
        {
            provider = function(self)
                return self.warn_icon
            end,
            hl = { fg = "#d4a959" },
        },
        {
            provider = function(self)
                return self.warnings .. "  "
            end,
            hl = { fg = "#FFCB6B", bold = true },
        },
    },
    {
        {
            provider = function(self)
                return self.info_icon
            end,
            hl = { fg = "#6c8ed4" },
        },
        {
            provider = function(self)
                return self.info .. "  "
            end,
            hl = { fg = "#82AAFF", bold = true },
        },
    },
    {
        {
            provider = function(self)
                return self.hint_icon
            end,
            hl = { fg = "#9fbd73" },
        },
        {
            provider = function(self)
                return self.hints .. "  "
            end,
            hl = { fg = "#C3E88D", bold = true },
        },
    },
}

local separator = { provider = "%=" }

local border = {
    provider = "▐" .. " ",
    hl = { fg = "#363a4e" },
}

local LSP = {
    {
        provider = " ",
        hl = { fg = "#a377bf" },
    },
    {
        provider = function()
            local names = vim.tbl_map(function(client)
                return client.name
            end, vim.lsp.get_clients({ bufnr = 0 }))

            return table.concat(names, " ")
        end,
        hl = { fg = "#6c8ed4", bold = true, italic = true },
    },
    Padding(1),
    border,
    update = { "LspAttach", "LspDetach" },
    condition = conditions.lsp_attached,
}

local Git = {
    condition = conditions.is_git_repo,
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and (" +" .. count .. " ")
        end,
        hl = { fg = "#C3E88D" },
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and (" -" .. count .. " ")
        end,
        hl = { fg = "#E06C75" },
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and (" ~" .. count .. " ")
        end,
        hl = { fg = "#82AAFF" },
    },
    {
        Padding(1),
        border,
        Padding(1),
        condition = function(self)
            return self.has_changes
        end,
    },
    {
        provider = function(self)
            return self.status_dict.head
        end,
        hl = { fg = "#C792EA", bold = true },
    },
    Padding(1),
}

local left = {
    Padding(1),
    Mode("  "),
    Padding(2),
    FileSize,
    Padding(2),
    FileIcon,
    FilePath,
    FileFlags,
    Padding(2),
    FileLines,
    Padding(2),
    Ruler,
    Padding(3),
    -- ScrollBar
}

local center = {
    Diagnostics,
}

local right = {
    LSP,
    Padding(1),
    Git,
    Padding(2),
    ScrollBar,
    Padding(1),
}

return {
    -- Mode("▉ "),
    left,
    separator,
    center,
    separator,
    right,
    -- Mode(" ▉"),
    hl = {
        bg = "#22252A",
        fg = "#c5cdd9",
    },
}
