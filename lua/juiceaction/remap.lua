vim.g.mapleader = " "

vim.opt.clipboard = "unnamedplus"

-- Adds <ALT> - Moving lines.
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==") -- Move line up in Normal mode
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==") -- Move line down in Normal mode
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- Move selection up in Visual mode
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- Move selection down in Visual mode

vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==") -- Move line down in Normal mode
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==") -- Move line up in Normal mode
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv") -- Move selection down in Visual mode
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv") -- Move selection up in Visual mode

-- Adds line jumping by quantities of n
--[[
local lineMoveQuantity = tostring(10)
vim.keymap.set("n", "<C-j>", lineMoveQuantity .. "j")
vim.keymap.set("n", "<C-k>", lineMoveQuantity .. "k")
vim.keymap.set("n", "<C-Up>", lineMoveQuantity .. "k")
vim.keymap.set("n", "<C-Down>", lineMoveQuantity .. "j")
vim.keymap.set("i", "<C-Up>", "<Esc>" .. lineMoveQuantity .. "ka")
vim.keymap.set("i", "<C-Down>", "<Esc>" .. lineMoveQuantity .. "ja")
]]
vim.keymap.set("n", "<C-j>", ":call search('^\\s*$', 'W')<CR>")
vim.keymap.set("n", "<C-k>", ":call search('^\\s*$', 'bW')<CR>")
vim.keymap.set("i", "<C-j>", "<Esc>:call search('^\\s*$', 'W')<CR>a")
vim.keymap.set("i", "<C-k>", "<Esc>:call search('^\\s*$', 'bW')<CR>a")
vim.keymap.set("n", "<C-Down>", ":call search('^\\s*$', 'W')<CR>")
vim.keymap.set("n", "<C-Up>", ":call search('^\\s*$', 'bW')<CR>")
vim.keymap.set("i", "<C-Down>", "<Esc>:call search('^\\s*$', 'W')<CR>a")
vim.keymap.set("i", "<C-Up>", "<Esc>:call search('^\\s*$', 'bW')<CR>a")

-- Returns to file directory
vim.keymap.set("n", "<C-d>", ":Neotree filesystem toggle<CR>")

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
vim.keymap.set("n", "<C-h>", "b", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "w", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Left>", "b", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Right>", "w", { noremap = true, silent = true })

-- Fuzzy search Barbar buffers with Telescope
-- Function to get only Barbar-managed buffers
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local bbye = require("barbar.bbye")

-- Adds ALT-n-DELETE mappings for deleting tabs
for i = 1, 10 do
    vim.keymap.set("n", "<A-" .. i .. ">", function()
        vim.cmd("BufferGoto " .. i)
    end, { noremap = true, silent = true })
end

local function refresh_picker(prompt_bufnr)
    local new_buffers = {} -- Get updated buffer list
    for i = 1, vim.fn.bufnr("$") do
        if vim.fn.buflisted(i) == 1 then
            table.insert(new_buffers, { name = vim.api.nvim_buf_get_name(i), bufnr = i })
        end
    end

    -- Restart Telescope with updated buffers
    require("telescope.pickers").new({}, {
        prompt_title = "Search Open Tabs",
        finder = require("telescope.finders").new_table({
            results = new_buffers,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.name,
                    ordinal = entry.name,
                    bufnr = entry.bufnr
                }
            end
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(new_prompt_bufnr, map)
            -- Close selected buffer and refresh
            map("i", "<Del>", function()
                local selection = action_state.get_selected_entry()
                if selection then
                    vim.api.nvim_buf_delete(selection.bufnr, { force = true })
                    refresh_picker(new_prompt_bufnr) -- Refresh after deletion
                end
            end)

            return true
        end,
    }):find()
end
vim.keymap.set("n", "<A-`>", function()
    refresh_picker(nil) -- Start picker initially
end, { noremap = true, silent = true })



-- Toggle Terminal
vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-t>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<Esc>", "<C-c><CR>exit<CR>", { noremap = true, silent = true }) -- Totally shuts down the terminal instance

-- Go to definition
vim.keymap.set("n", "<CR>", function()
    local clients = vim.lsp.get_clients()
    if clients and #clients > 0 then
        vim.lsp.buf.definition()
    else
        print("No active LSP servers")
    end
end, { noremap = true, silent = true })

-- Suggest fixes on error. If there's no error, instead show code docs.
local _border = "rounded"

local function bordered_hover(_opts)
    _opts = _opts or {}
    return vim.lsp.buf.hover(vim.tbl_deep_extend("force", _opts, {
        border = _border
    }))
end

local function bordered_code_action(_opts)
    _opts = _opts or {}
    return vim.lsp.buf.code_action(vim.tbl_deep_extend("force", _opts, {
        border = _border,
        context = { only = { "quickfix" } } -- Ensure only error fixes appear
    }))
end

vim.keymap.set("n", "<Tab>", function()
    local diagnostics = vim.diagnostic.get(vim.api.nvim_get_current_buf())

    bordered_hover({ focusable = false }) -- Show hover first

    if #diagnostics > 0 then
        vim.defer_fn(function()
            bordered_code_action({})
        end, 100) -- Delay slightly to ensure hover shows first
    end
end, { noremap = true, silent = true })

