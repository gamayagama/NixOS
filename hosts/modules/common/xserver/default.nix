{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    displayManager.lightdm = {
      enable = true;

      greeters.gtk = {
        enable = true;
        theme = {
          package = pkgs.graphite-gtk-theme;
          name = "Graphite";
        };
        iconTheme = {
          package = pkgs.vimix-icon-theme;
        name = "Vimix";
        };
      };
    };

    desktopManager.plasma5.enable = true;
    windowManager.leftwm.enable = true;

    layout = "us";
    xkbVariant = "";
    xkbOptions = "ctrl:nocaps";
  };

  environment.systemPackages = with pkgs; [
    rofi
  ];
}
