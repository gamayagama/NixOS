
function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

local telescopeBuiltin = require('telescope.builtin')

-- Search using ripgrep
-- NOTE: grep_string() doesn't work correctly with cwd option so only live_grep() is available
Map('n', "<leader>s", function()
  local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
  if vim.v.shell_error == 0 then
    telescopeBuiltin.live_grep({ cwd = root })
  else
    telescopeBuiltin.live_grep()
  end
end, { desc = "Search in files" })

-- Open file
Map('n', "<leader>o", function()
  vim.fn.system("git rev-parse --is-inside-git-tree")
  if vim.v.shell_error == 0
  then
    telescopeBuiltin.git_files()
  else
    telescopeBuiltin.find_files()
  end
end, { desc = "Open file" })
