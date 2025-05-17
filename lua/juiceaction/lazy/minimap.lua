return {
    'gorbit99/codewindow.nvim',
    config = function()
        local codewindow = require('codewindow')
        codewindow.setup({
            auto_enable = true,  -- Automatically open the minimap
            minimap_width = 20,  -- Width of the minimap
            use_treesitter = true,  -- Enable Treesitter highlights
            use_lsp = true,  -- Show LSP diagnostics
            window_border = 'rounded',  -- Border style
            events = { 'InsertLeave', 'FileWritePost' },
            screen_bounds = "background",
        })

        vim.api.nvim_set_hl(0, 'CodewindowBorder', {fg = '#111111'})

        codewindow.apply_default_keybinds()
    end,
}
