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
            setopt = true,
            -- override the default list of segments with:
            -- number-less fold indicator, line number and git + diagnostic sign
            segments = {
                {
                    text = { builtin.foldfunc },
                    click = "v:lua.ScFa",
                },
                {
                    text = { builtin.lnumfunc },
                    click = "v:lua.ScLa",
                },
                {
                    text = { " " },
                },
                {
                    text = { "%s" },
                    click = "v:lua.ScSa",
                },
            },
        }
    end,
}
