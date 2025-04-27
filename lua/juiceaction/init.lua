vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.g.mapleader = " "
vim.opt.signcolumn = "yes:2"
vim.api.nvim_create_autocmd("BufEnter", { -- automatically calculate width of line number column based on highest number
    pattern = "*",
    callback = function()
        local max_line = vim.fn.line("$")
        local width = #tostring(max_line) + 1 -- +1 for spacing
        vim.opt.numberwidth = math.max(3, width) -- Ensure a minimum width
    end,
})
vim.opt.relativenumber = true -- (Optional) Enables relative numbering
vim.opt.number = true        -- Show absolute line numbers

-- When "nvim" is called, nobody cares about the home screen automatically just run "nvim ."
local args = vim.fn.argv()
if #args == 0 then
    vim.cmd('cd .')
    vim.cmd('edit .')
end

require("juiceaction.lazy_init")



require("mason").setup()



require("juiceaction.remap")
require("juiceaction.autocmd")
