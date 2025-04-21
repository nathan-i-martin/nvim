-- Telescope
local telescope = require("telescope")
telescope.setup({
  defaults = {
    file_ignore_patterns = { "^%." },
  },
  pickers = {
    find_files = {
      hidden = true, -- Include hidden files in the search
    },
  },
  find_files = {
    find_command = { "fd", "--hidden", "--exclude", ".*" },
  },
})
