vim.g.mapleader = " "

vim.opt.clipboard = "unnamedplus"

-- Pullup auto-docs on hovered item
vim.keymap.set("n", "<Tab>", function()
    vim.lsp.buf.hover({ focusable = false })
end, { noremap = true, silent = true })

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
vim.keymap.set("n", "<C-Up>", lineMoveQuantity .. "k")
vim.keymap.set("n", "<C-Down>", lineMoveQuantity .. "j")
vim.keymap.set("i", "<C-Up>", "<Esc>" .. lineMoveQuantity .. "ka")
vim.keymap.set("i", "<C-Down>", "<Esc>" .. lineMoveQuantity .. "ja")

-- Returns to file directory
vim.keymap.set("n", "<C-d>", vim.cmd.Ex)

-- Writes buffer to file
vim.keymap.set("n", "<C-s>", vim.cmd.write)
vim.keymap.set("i", "<C-s>", vim.cmd.write)

-- Telescope key bindings
local telescope = require("telescope.builtin")
vim.keymap.set("n","<C-p>", telescope.find_files, {})
vim.keymap.set("n","<C-f>", telescope.live_grep, {})

-- Git
vim.keymap.set("n","<leader>gs", vim.cmd.Git)

-- Delete whole words
vim.keymap.set("i", "<C-h>", "<C-w>", { noremap = true })
vim.keymap.set("i", "<C-Del>", "<Right><Esc>vwh<Del><Esc>i", { noremap = true }) -- Very specifically adds CTRL+Delete behaviour as many platforms handle it

-- Add CTRL mappings instead of forcing w or b
vim.keymap.set("n", "<C-h>", "b", { noremap = true, silent = true }) -- Ctrl+H moves left by a word
vim.keymap.set("n", "<C-l>", "w", { noremap = true, silent = true }) -- Ctrl+L moves right by a word

-- Harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>a", function()
    if vim.bo.buftype ~= "terminal" then
        harpoon:list():add() -- Add file only if not in a terminal buffer
    end
end, { noremap = true, silent = true })

vim.keymap.set("n", "<A-1>", function() harpoon:list():select(1) end, { noremap = true, silent = true })
vim.keymap.set("n", "<A-2>", function() harpoon:list():select(2) end, { noremap = true, silent = true })
vim.keymap.set("n", "<A-3>", function() harpoon:list():select(3) end, { noremap = true, silent = true })
vim.keymap.set("n", "<A-4>", function() harpoon:list():select(4) end, { noremap = true, silent = true })
vim.keymap.set("n", "<A-5>", function() harpoon:list():select(5) end, { noremap = true, silent = true })
vim.keymap.set("n", "<A-6>", function() harpoon:list():select(6) end, { noremap = true, silent = true })
vim.keymap.set("n", "<A-7>", function() harpoon:list():select(7) end, { noremap = true, silent = true })
vim.keymap.set("n", "<A-8>", function() harpoon:list():select(8) end, { noremap = true, silent = true })
vim.keymap.set("n", "<A-9>", function() harpoon:list():select(9) end, { noremap = true, silent = true })
vim.keymap.set("n", "<A-0>", function() harpoon:list():select(10) end, { noremap = true, silent = true })

-- Toggle Terminal
vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-t>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<Esc>", "<C-c><CR>exit<CR>", { noremap = true, silent = true }) -- Totally shuts down the terminal instance

