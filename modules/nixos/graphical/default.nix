{ inputs, config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  environment.sessionVariables = {
    # Hint Electron apps to use Wayland
    NIXOS_OZONE_WL = "1";
    # Enable if cursor becomes invisible
    # WLR_NO_HARDWARE_CURSORS = "1";
  };

  services = {
    displayManager = {
      defaultSession = "plasma";
    };
    desktopManager.plasma6.enable = true;
    xserver = {
      enable = true;
        displayManager = {
          lightdm = {
          enable = true;
          greeters = {
            slick = {
              enable = true;
            };
          };
        };
      };
      # windowManager = {
        # awesome.enable = true;
          # (Need configuration) Looks terrible but is significantly more functional than both bspwm and spectrwm out of the box
          # Configuration in lua is great as it is also used for nvim
      # };
    };
  };
}
