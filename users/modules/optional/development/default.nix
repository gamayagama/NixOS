{ config, pkgs, ... }:

{
  programs = {

    java = {
      enable = true;
    };

    git = {
      enable = true;
      userEmail = "fmrh@pm.me";
      userName = "Fillip Holgersen";
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
