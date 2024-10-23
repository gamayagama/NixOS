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
          greeters.slick.enable = true;
        };
      };
    };
  };
}
