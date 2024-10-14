{ config, pkgs, ... }:

{
  xsession.windowManager = {
    awesome.enable = true;

  #   spectrwm = {
  #     enable = true;
  #     settings = {
  #       modkey = "Mod4";
  #       bar_border = 0;
  #     };
  #     bindings = {
  #       term = "Mod+Return";
  #     };
  #     programs = {
  #       term = "kitty";
  #       menu = "rofi -show drun";
  #       search = "rofi -show window";
  #     };
  #   };

    bspwm = {
      enable = true;
      monitors = {
       default = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
      };
      startupPrograms = [
        "pgrep +x sxhkd > /dev/null || sxhkd"
      ];
      rules = {};
      settings = {
        border_width = 2;
      };
    };
  };

  services = {
    sxhkd = {
      enable = true;
      keybindings = {
        "super + Return" = "kitty";
        "super + shift + Return" = "rofi -show drun";
        "super + shift + q" = "bspc quit";
        "super + shift + r" = "bspc wm -r";
      };
    };
  };

  # home.packages = with pkgs; [ xlockmore ];

  programs.rofi = {
    enable = true;
    terminal = "kitty";
    plugins = with pkgs; [ rofi-calc ];

  };

  services.flameshot = {
    enable = true;
  };

  # Enable systemd target unit needed for flameshot
  # See [Unit tray.target not found](https://github.com/nix-community/home-manager/issues/2064) for more information
  # credit to user 'zeorin' for the workaround
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
}
