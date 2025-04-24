return {
    { "nvim-lua/plenary.nvim" },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup()
        end,
    },
}
