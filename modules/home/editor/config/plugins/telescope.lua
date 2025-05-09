local telescope = require'telescope'

telescope.setup({
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- DEFAULT: "smart_case", can also be "ignore_case" or "respect_case"
    }
  }
})

telescope.load_extension('fzf')
