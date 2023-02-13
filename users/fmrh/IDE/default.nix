{ config, pkgs, lib, ... }:

let
  myExtentions = with pkgs.vscode-extensions; [
    # Themes
    pkief.material-icon-theme
    # teabyii.ayu

    # Language support
    jnoortheen.nix-ide
    yzhang.markdown-all-in-one
    dbaeumer.vscode-eslint


    # Testing
    ritwickdey.liveserver

    # QOL
    # vscodevim.vim
    esbenp.prettier-vscode
    formulahendry.auto-rename-tag
    eamodio.gitlens
  ];

  mySettings = import ./settings.nix;

in {
  programs.vscode = {
    enable = true;
    extensions = myExtentions;
    userSettings = mySettings;
  };

  home.packages = with pkgs; [ jetbrains.idea-community ];
}
