return {
    'gorbit99/codewindow.nvim',
    config = function()
        local codewindow = require('codewindow')
        codewindow.setup({
            auto_enable = true,
            minimap_width = 20,
            use_treesitter = true,
            use_lsp = true,
            window_border = 'rounded',
            events = { 'InsertLeave', 'FileWritePost' },
            screen_bounds = "background",
        })

        vim.api.nvim_set_hl(0, 'CodewindowBorder', {fg = '#111111'})

        codewindow.apply_default_keybinds()

        -- Hide minimap in insert mode
        vim.api.nvim_create_autocmd("InsertEnter", {
            callback = function()
                codewindow.close_minimap()
            end
        })

        vim.api.nvim_create_autocmd("InsertLeave", {
            callback = function()
                codewindow.open_minimap()
            end
        })
    end,
}
