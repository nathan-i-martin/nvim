return {
  {'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
      'nvim-telescope/telescope.nvim', -- Add Telescope for fuzzy searching tabs
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      icons = { filetype = { enabled = true } }, -- Keep file icons
      truncate = { length = 30, smart = true }, -- Shorten long paths intelligently
      custom_filter = function(buf_number, buf_name)
        local filename = vim.fn.fnamemodify(buf_name, ":t") -- Extract filename only
        local duplicates = 0
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t") == filename then
            duplicates = duplicates + 1
          end
        end
        if duplicates > 1 then
          return vim.fn.fnamemodify(buf_name, ":~:.") -- Show partial path for duplicates
        else
          return filename -- Show only filename
        end
      end,
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
}
