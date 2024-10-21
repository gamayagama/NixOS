{ config, pkgs, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
  '';

in {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = ''
        ${startupScript}/bin/start
      '';
    };
  };
  services = {
    # sxhkd = {
    #   enable = true;
    #   keybindings = {
    #     "super + Return" = "kitty";
    #     "super + shift + Return" = "rofi -show drun";
    #     "super + shift + q" = "bspc quit";
    #     "super + shift + r" = "bspc wm -r";
    #   };
    # };

    hyprpaper = {
      enable = true;
      settings = {
        preload = "./wallpaper.png";
        wallpaper = "./wallpaper.png";
      };
    };
    flameshot.enable = true;
  };

  programs = {
    hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
          ignore_empty_input = true;
        };
        background = [
          {
            path = "screenshot";
            blur_passes = 3;
            blur_size = 8;
          };
        ];
        input-field = [
          {
            size = "200, 50";
          }
        ];
      };
    };
    tofi = {
      enable = true;
      settings = {
        font = "Hack";
        font-size = 30;

        prompt-text = " ";

        border-width = 0;
        outline-width = 0;
        padding-left = "5%";
        padding-top = "5%";
        padding-right = "0%";
        padding-bottom = "0%";

        # background-color = "#000000";
        # text-color = "#FFFFFF";
        # selection-color = "#939393";

        hide-cursor = true;
        num-results = 5;
        matching-algorithm = "fuzzy";
        terminal = "kitty";
      };
    };
    dunst = {
      enable = true;
      settings = {};
      iconTheme = {};
    };
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
