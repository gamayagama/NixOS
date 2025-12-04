{
  pkgs,
  inputs,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Hint Electron apps to use Wayland
  environment.variables.NIXOS_OZONE_WL = "1";

  services = {
    displayManager = {
      ly.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };
}
