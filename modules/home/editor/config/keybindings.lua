function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

local telescopeBuiltin = require('telescope.builtin')

Map('n', "<leader>ff", telescopeBuiltin.find_files, { desc = "Find files in directory"})
Map('n', "<leader>pf", telescopeBuiltin.git_files, { desc = "Project files" })
-- TODO: this does not search in git project, so keybinding should reflect this
-- Consider a separate group for git tasks
Map('n', "<leader>ps", function()
  telescopeBuiltin.grep_string({ search = vim.fn.input("Project search > ") })
end, { desc = "Project search" })
