-- ╭──────────────╮
-- │  NIX SERVER  │
-- ╰──────────────╯

require('lspconfig').nixd.setup({
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import (builtins.getFlake '/home/gama/.config/nixos').inputs.nixpkgs { }",
      },
      formatting = {
        command = { "alejandra" },
      },
      options = {
        nixos = {
          expr = "(builtins.getFlake '/home/gama/.config/nixos').nixosConfigurations.nyx.options",
        },
        home_manager = {
          expr = "(builtins.getFlake '/home/gama/.config/nixos').homeConfigurations.gama.options",
        },
      },
    },
  },
})

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

