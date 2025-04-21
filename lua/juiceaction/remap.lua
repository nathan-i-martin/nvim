vim.g.mapleader = " "

-- Inserting tabs
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- Adds <ALT> - Moving lines.
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==") -- Move line down in Normal mode
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==") -- Move line up in Normal mode
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- Move selection down in Visual mode
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- Move selection up in Visual mode

vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==") -- Move line down in Normal mode
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==") -- Move line up in Normal mode
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv") -- Move selection down in Visual mode
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv") -- Move selection up in Visual mode

-- Adds line jumping by quantities of n
local lineMoveQuantity = tostring(10)
vim.keymap.set("n", "<C-j>", lineMoveQuantity .. "j")
vim.keymap.set("n", "<C-k>", lineMoveQuantity .. "k")
vim.keymap.set("n", "<C-Down>", lineMoveQuantity .. "j")
vim.keymap.set("n", "<C-Up>", lineMoveQuantity .. "k")

-- Returns to file directory
vim.keymap.set("n", "<leader>d", vim.cmd.Ex)

-- Telescope key bindings
local telescope = require("telescope.builtin")
vim.keymap.set("n","<C-p>", telescope.find_files, {})
vim.keymap.set("n","<leader>fg", telescope.live_grep, {})

-- Git
vim.keymap.set("n","<leader>gs", vim.cmd.Git)
