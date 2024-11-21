function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

---------------------------
--- General keybindings ---
---------------------------

-- Keep cursor centered
Map("n", "<C-d>", "<C-d>zz")
Map("n", "<C-u>", "<C-u>zz")
Map("n", "n", "nzzzv")
Map("n", "N", "Nzzzv")

-- Move selection up and down
Map("v", "J", ":m '>+1<CR>gv=gv")
Map("v", "K", ":m '<-2<CR>gv=gv")

-- Yank (copy) to system clipboard
Map("n", "<leader>y", "\"+y")
Map("v", "<leader>y", "\"+y")
Map("n", "<leader>Y", "\"+Y")

-- Prevent accidental Ex mode
Map("n", "gQ", "<nop>")

-- Replace all instances of word under cursor
Map("n", "<leader>ra", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
--------------------------
--- Plugin keybindings ---
--------------------------

local telescopeBuiltin = require('telescope.builtin')

-- Search using ripgrep
-- NOTE: grep_string() doesn't work correctly with cwd option so only live_grep() is available
Map("n", "<leader>s", function()
  local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
  if vim.v.shell_error == 0 then
    telescopeBuiltin.live_grep({ cwd = root })
  else
    telescopeBuiltin.live_grep()
  end
end, { desc = "Search in files" })

-- Open file
Map("n", "<leader>o", function()
  vim.fn.system("git rev-parse --is-inside-git-tree")
  if vim.v.shell_error == 0
  then
    telescopeBuiltin.git_files()
  else
    telescopeBuiltin.find_files()
  end
end, { desc = "Open file" })
