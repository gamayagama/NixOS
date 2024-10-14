{ config, pkgs, ... }:

  let
    myAliases = {
      ls = "ls -lAh -gS --color";
      ping = "ping -c 5";
      diff = "diff --color";
    };

  in {
    programs = {
      zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        autocd = true;
        shellAliases = myAliases;
      };
      starship = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  }
