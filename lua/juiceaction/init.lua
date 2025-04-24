vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"

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
