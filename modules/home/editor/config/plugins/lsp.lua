-- ╭───────────────────╮
-- │  Vars and setup   │
-- ╰───────────────────╯

local cmp = require'cmp'
local lsp = require'lspconfig'
local luasnip = require'luasnip'

require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup{}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- ╭──────────────╮
-- │  Completion  │
-- ╰──────────────╯

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
  mapping = cmp.mapping.preset.insert {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
}

-- ╭──────────────╮
-- │  NIX SERVER  │
-- ╰──────────────╯

lsp.nixd.setup({
  capabilities = capabilities,
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

lsp.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    flake = { autoArchive = true },
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

