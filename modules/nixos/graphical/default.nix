{ config, pkgs, ... }:

{
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
      windowManager = {
        # bspwm.enable = true;
          # (Testing) Requires a lot of configuration to reach basic functionality
          # Will never be as powerful as Awesome, but is easier to configure
        awesome.enable = true;
          # (Need configuration) Looks terrible but is significantly more functional than both bspwm and spectrwm out of the box
          # Configuration in lua is great as it is also used for nvim
      };
    };
  };
}
