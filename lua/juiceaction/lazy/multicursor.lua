return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        local set = vim.keymap.set

        -- Add or skip cursor above/below the main cursor.
        set({"n", "x"}, "<C-A-up>", function() mc.lineAddCursor(-1) end)
        set({"n", "x"}, "<C-A-down>", function() mc.lineAddCursor(1) end)

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)
            -- Delete the main cursor.
            layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)

            layerSet({"n", "x"}, "<A-right>", mc.nextCursor)
            layerSet({"n", "x"}, "<A-left>", mc.prevCursor)


            -- Enable and clear cursors using escape.
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl

        -- Set all cursors to red
        hl(0, "MultiCursorCursor", { fg = "#FF0000", bg = "#440000", bold = true }) -- Red cursors
        hl(0, "MultiCursorVisual", { fg = "#FF0000", bg = "#440000", bold = true }) -- Red selection
        hl(0, "MultiCursorSign",   { fg = "#FF0000", bg = "#440000", bold = true }) -- Red sign column indicator

        -- Set the current cursor to yellow
        hl(0, "MultiCursorMatchPreview", { fg = "#FFFF00", bg = "#444400", bold = true }) -- Yellow preview
        hl(0, "MultiCursorDisabledCursor", { fg = "#FF0000", bold = true }) -- Keep disabled cursors red
        hl(0, "MultiCursorDisabledVisual", { fg = "#FF0000", bg = "#440000", bold = true }) -- Keep disabled selection red
        hl(0, "MultiCursorDisabledSign", { fg = "#FF0000", bold = true }) -- Keep disabled sign red
    end
}
