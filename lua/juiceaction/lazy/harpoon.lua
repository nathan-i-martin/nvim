return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },

    config = function()
        local harpoon = require("harpoon")
        harpoon.setup({})

        -- Basic telescope configuration
        local conf = require("telescope.config").values

        -- Function to toggle Telescope for Harpoon
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
                attach_mappings = function(_, map)
                    map("i", "<CR>", function()
                        local selection = require("telescope.actions.state").get_selected_entry()
                        if selection then
                            vim.cmd("edit! " .. selection.value) -- Open the selected file
                        end
                    end)

                    map("i", "<Del>", function()
                        local selection = require("telescope.actions.state").get_selected_entry()
                        if selection then
                            local list = harpoon:list()
                            local index = selection.index

                            if index then
                                local new_items = {}
                                for i, item in ipairs(list.items) do
                                    if i ~= index then
                                        table.insert(new_items, item)
                                    end
                                end
                                list.items = new_items -- Overwrite Harpoon's list with the filtered version
                            end

                            vim.schedule(function()
                                toggle_telescope(list)
                            end)
                        end
                    end)
                    return true
                end,
            }):find()
        end

        -- Keybindings
        vim.keymap.set("n", "<C-a>", function() toggle_telescope(harpoon:list()) end, { desc = "Open Harpoon in Telescope" })
    end,
}
