{ pkgs, ... }:
let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      fd
      ripgrep
      xclip
      wl-clipboard

      # Language servers
      nixd # Nix
      lua-language-server # Lua
    ];
    plugins = with pkgs.vimPlugins; [
      # Plugins can be loaded and configured at once
      # See example below:

      # {
      #   plugin = plugin-name;
      # Use the appropriate config method
      #   config = toLuaFile ./configfile.lua;
      #   config = toLua "lua code";
      #   config = "vimscript code";
      # }

      {
        plugin = leap-nvim;
        config = toLua "require('leap').create_default_mappings()";
      }
      {
        plugin = oil-nvim;
        config = toLua "require('oil').setup()";
      }
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./config/plugins/lsp.lua;
      }
      {
        plugin = nvim-web-devicons;
        config = toLua "require('nvim-web-devicons').setup()";
      }
      {
        plugin = lualine-nvim;
        config = toLuaFile ./config/plugins/lualine.lua;
      }
      {
        plugin = gruvbox-material-nvim;
        config = toLuaFile ./config/plugins/gruvbox-material.lua;
      }
      {
        plugin = gitsigns-nvim;
        config = toLua "require('gitsigns').setup()";
      }
      {
        plugin = which-key-nvim;
        config = toLua "require('which-key').setup()";
      }
      {
        plugin = comment-nvim;
        config = toLua "require('Comment').setup()";
      }
      {
        plugin = telescope-nvim;
        config = toLuaFile ./config/plugins/telescope.lua;
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        config = toLuaFile ./config/plugins/treesitter.lua;
      }
      {
        plugin = indent-blankline-nvim;
        config = toLua "require('ibl').setup()";
      }
      {
        plugin = nvim-autopairs;
        config = toLua "require('nvim-autopairs').setup()";
      }
      {
        plugin = nvim-surround;
        config = toLua "require('nvim-surround').setup()";
      }
      {
        plugin = nvim-tree-lua;
        config = toLua "require('nvim-tree').setup()";
      }
      # Required by other plugins
      plenary-nvim
      telescope-fzf-native-nvim
      nvim-cmp
      cmp_luasnip
      cmp-nvim-lsp
      luasnip
      friendly-snippets
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./config/options.lua}
      ${builtins.readFile ./config/keybindings.lua}
    '';
  };
}
