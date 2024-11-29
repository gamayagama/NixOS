{
  pkgs,
  inputs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };

  # Hint Electron apps to use Wayland
  environment.variables.NIXOS_OZONE_WL = "1";

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
