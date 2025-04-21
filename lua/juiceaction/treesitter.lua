require('nvim-treesitter.configs').setup({
    ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "java",
        "html",
        "css",
        "go",
        "sql"
    }, -- The languages you want Treesitter to support
    highlight = {
        enable = true, -- Enables syntax highlighting
        additional_vim_regex_highlighting = false, -- Ensures there's no conflict with standard regex highlighting
    },
    indent = {
        enable = true, -- Enables automatic indentation based on Treesitter
    },
})
