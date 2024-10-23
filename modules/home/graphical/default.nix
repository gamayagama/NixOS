{
  services = {
    flameshot.enable = true;
  };

  # Enable systemd target unit needed for flameshot
  # See [Unit tray.target not found](https://github.com/nix-community/home-manager/issues/2064) for more information
  # credit to user 'zeorin' for the workaround
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };
}
