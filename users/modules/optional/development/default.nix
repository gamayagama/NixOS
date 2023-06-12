{ config, pkgs, ... }:

{
  programs = {

    java = {
      enable = true;
    };

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

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    pinentryFlavor = "qt";
  };
}
