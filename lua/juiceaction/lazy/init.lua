return {
    { "nvim-lua/plenary.nvim" },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup()
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            local autotag = require('nvim-ts-autotag')
            autotag.setup({
                opts = {
                    enable_close = true,  -- Auto close tags
                    enable_rename = true, -- Auto rename paired tags
                    enable_close_on_slash = true
                }
            })
        end,
    }
}
