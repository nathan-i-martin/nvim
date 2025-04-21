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

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        "askfiy/visual_studio_code",
        priority = 100,
        config = function()
            vim.cmd([[colorscheme visual_studio_code]])
        end,
    },
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate"
    },
    {
        "ThePrimeagen/harpoon",
        config = function()
            require("harpoon").setup({
                -- Add any configuration options here
                global_settings = {
                    save_on_change = true,  -- Saves changes automatically
                    enter_on_sendcmd = false, -- Prevent entering terminal automatically
                },
            })
        end,
    },


    { 'tpope/vim-fugitive' },

    -- LSP Zero
    { 'neovim/nvim-lspconfig'},
    { 'hrsh7th/cmp-nvim-lsp'},
    { 'hrsh7th/nvim-cmp'},

    -- Because I'm using Mason for lsp, need to install these
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
}
local opts = {}





require("lazy").setup(plugins, opts)




require("mason").setup()




require("juiceaction.treesitter")
require("juiceaction.telescope")
require("juiceaction.lsp")





require("juiceaction.remap")
