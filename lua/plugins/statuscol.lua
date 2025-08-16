return {
    "luukvbaal/statuscol.nvim",
    init = function()
        local vim_o = vim.o
        vim_o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        vim_o.foldcolumn = "1"
        vim_o.foldlevel = 99
        vim_o.foldlevelstart = 99
        vim_o.foldenable = true
        vim_o.foldmethod = "expr"
        vim_o.foldexpr = "v:lua.vim.lsp.foldexpr()"
    end,
    opts = function()
        local builtin = require("statuscol.builtin")
        return {
            relculright = true,
            -- setopt = true,
            -- override the default list of segments with:
            -- number-less fold indicator, then signs, then line number & separator
            segments = {
                { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                {
                    sign = { name = { "diagnostic/signs" }, maxwidth = 2, auto = true },
                    click = "v:lua.ScSa",
                },
                { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
                { text = { " " } },
                {
                    sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
                    click = "v:lua.ScSa",
                },
                { text = { "%s" }, click = "v:lua.ScSa" },
                -- {
                --     text = { builtin.lnumfunc, " " },
                --     condition = { true, builtin.not_empty },
                --     click = "v:lua.ScLa",
                -- },
            },
        }
    end,
}
