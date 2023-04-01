{ config, pkgs, ... }:

{
  services.flameshot = {
    enable = true;
  };

  # Enable tray unit for flameshot due to a bug not enabling it
  # See more: https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
		Unit = {
			Description = "Home Manager System Tray";
			Requires = [ "graphical-session-pre.target" ];
		};
	};

  programs.mpv = {
    enable = true;
  };
}
