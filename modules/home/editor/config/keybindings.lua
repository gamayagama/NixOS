function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

local telescopeBuiltin = require('telescope.builtin')

Map('n', "<leader>ff", telescopeBuiltin.find_files, {})
Map('n', "<leader>pf", telescopeBuiltin.git_files, {})
Map('n', "<leader>ps", function()
  telescopeBuiltin.grep_string({ search = vim.fn.input("Project search > ") })
end)
