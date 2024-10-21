{ config, pkgs, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.sxhkd}/bin/sxhkd &
    killall -q hyprpaper || hyprpaper
  '';

in {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = ''
        ${startupScript}/bin/start
      '';
      general = {
        border_size = 2;
        # no_border_on_floating = true;
        gaps_in = 1;
        gaps_out = 3;
        "col.inactive_border" = "rgba(90678b88)";
        "col.active_border" = "rgba(e0a5d9ff)";
        layout = "master";
      };
      decoration = {
        rounding = 2;
        drop_shadow = true;
        shadow_range = 4;
        "col.shadow" = "rgba(1a1a1aee)";
      };
      input = {
        scroll_method = "2fg";
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_forever = true;
      };
      misc = {
        disable_hyprland_log = true;
        disable_spash_rendering = true;
      };
    };
  };
  services = {
    sxhkd = {
      enable = true;
      keybindings = {
        "super + Return" = "kitty";
        "super + shift + Return" = "tofi";
      };
    };

    hyprpaper = {
      enable = true;
      settings = {
        preload = "./wallpaper.png";
        wallpaper = "./wallpaper.png";
      };
    };

    flameshot.enable = true;

    dunst = {
      enable = true;
      settings = {};
      # iconTheme = {};
    };
  };

  programs = {
    waybar = {
      enable = true;
      settings = {};
      # style = ./config/waybar.css;
    };
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
          }
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
