{
  services = {
    displayManager = {
      ly.enable = true;
    };
    # desktopManager.plasma6.enable = true;
    xserver = {
      enable = true;
      desktopManager.cinnamon.enable = true;
      # displayManager = {
        # lightdm = {
        #   enable = true;
        #   greeters.slick.enable = true;
        # };
      # };
    };
  };
}
