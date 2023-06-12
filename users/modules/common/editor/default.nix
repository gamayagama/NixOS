{ config, pkgs, lib, ... }:

let
  myVimPlugins = with pkgs.vimPlugins; [
    vim-which-key
    multiple-cursors

    nvim-tree-lua
    telescope-nvim

    vim-fugitive

    nvim-treesitter
    vim-nix
    vim-css-color

    vim-gruvbox8
    #vim-airline
    #vim-airline-themes
    rainbow_parentheses-vim
  ];

  baseConfig = builtins.readFile ./configs/init.vim;
  keybindConfig = builtins.readFile ./configs/keybinds.vim;
  pluginsConfig = builtins.readFile ./configs/plugins.vim;

  myVimConfig = baseConfig + keybindConfig + pluginsConfig;

in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # withNodeJs = true;
    withPython3 = true;
    # withRuby = true;

    plugins = myVimPlugins;
    extraConfig = myVimConfig;
  };
}
