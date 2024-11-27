{
  pkgs,
  inputs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  services = {
    displayManager = {
      ly.enable = true;
    };
    xserver = {
      enable = true;
      desktopManager.cinnamon.enable = true;
    };
  };
}
