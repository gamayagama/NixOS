-- ╭──────────────╮
-- │  NIX SERVER  │
-- ╰──────────────╯

require('lspconfig').nil_ls.setup{}

-- ╭──────────────╮
-- │  LUA SERVER  │
-- ╰──────────────╯

require('lspconfig').lua_ls.setup {
  settings = {
    flake = { autoArchive = true },
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

