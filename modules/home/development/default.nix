{ config, pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      userEmail = "admin@gama.pm";
      userName = "Gamayun Robakov";
      extraConfig = {
        init = { defaultBranch = "main"; };
      };
    };
    gpg = {
      enable = true;
    };
  };
}
