{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = false;
    withRuby = false;
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

      {
        plugin = oil-nvim;
        config = "require('oil').setup()";
        type = "lua";
      }
      {
        plugin = nvim-lspconfig;
        config = builtins.readFile ./config/plugins/lsp.lua;
        type = "lua";
      }
      {
        plugin = nvim-web-devicons;
        config = "require('nvim-web-devicons').setup()";
        type = "lua";
      }
      {
        plugin = lualine-nvim;
        config = builtins.readFile ./config/plugins/lualine.lua;
        type = "lua";
      }
      {
        plugin = gruvbox-material-nvim;
        config = builtins.readFile ./config/plugins/gruvbox-material.lua;
        type = "lua";
      }
      {
        plugin = gitsigns-nvim;
        config = "require('gitsigns').setup()";
        type = "lua";
      }
      {
        plugin = which-key-nvim;
        config = "require('which-key').setup()";
        type = "lua";
      }
      {
        plugin = comment-nvim;
        config = "require('Comment').setup()";
        type = "lua";
      }
      {
        plugin = telescope-nvim;
        config = builtins.readFile ./config/plugins/telescope.lua;
        type = "lua";
      }
      {
        plugin = nvim-treesitter;
        config = builtins.readFile ./config/plugins/treesitter.lua;
        type = "lua";
      }
      {
        plugin = indent-blankline-nvim;
        config = "require('ibl').setup()";
        type = "lua";
      }
      {
        plugin = nvim-autopairs;
        config = "require('nvim-autopairs').setup()";
        type = "lua";
      }
      {
        plugin = nvim-surround;
        config = "require('nvim-surround').setup()";
        type = "lua";
      }
      {
        plugin = nvim-tree-lua;
        config = "require('nvim-tree').setup()";
        type = "lua";
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

    initLua = ''
      ${builtins.readFile ./config/options.lua}
      ${builtins.readFile ./config/keybindings.lua}
    '';
  };
}
