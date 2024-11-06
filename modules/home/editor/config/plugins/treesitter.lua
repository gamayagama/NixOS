require('nvim-treesitter.configs').setup {
  auto_install = false,
  indent = {
    enable = true,
    disable = { "python", "yaml" },
  },
  highlight = {
    enable = true,
    disable = { "yaml" },
    additional_vim_regex_highlighting = false,
  },
}
