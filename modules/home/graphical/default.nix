{
  inputs,
  pkgs,
  ...
}: let
  startupScript = pkgs.writeShellScriptBin "start" ''
    ${pkgs.swww}/bin/swww-daemon &
    ${pkgs.mako}/bin/mako &
    systemctl --user enable --now hyprpolkitagent.service
    wl-paste --watch cliphist store
    udiskie &

    sleep 1

    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww img ${./wallpaper.png} &
  '';
in {
  # Dependencies
  home = {
    packages = with pkgs; [
      hyprpolkitagent
      slurp
      grim
      satty
      wleave
      cliphist
      udiskie
    ];
    sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };
  };

  # Configure Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    plugins = [];
    systemd = {
      enable = false; # This setting conflicts with uwsm
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
    settings = {
      exec-once = [
        "uwsm finalize"
        "${startupScript}/bin/start"
      ];
      "$mod" = "SUPER";
      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 1;
      };
      bind =
        [
          # Basic functionality
          "$mod, Q, killactive"
          "$mod, F, togglefloating"
          "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

          # Launch common programs
          "$mod_SHIFT, Return, exec, kitty"
          "$mod, Return, exec, rofi -show drun"

          # Vim-like navigation
          "$mod, H, movefocus, l"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, r"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
    };
  };

  programs = {
    waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          spacing = 2;

          modules-left = ["hyprland/workspaces"];
          modules-center = ["clock"];
          modules-right = ["network" "custom/screenshot" "custom/power"];

          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              "1" = "Ⅰ";
              "2" = "Ⅱ";
              "3" = "Ⅲ";
              "4" = "Ⅳ";
              "5" = "Ⅴ";
              "6" = "Ⅵ";
              "7" = "Ⅶ";
              "8" = "Ⅷ";
              "9" = "Ⅸ";
            };
            persistent-workspaces = {"*" = 9;}; # Show all workspaces
          };
          "clock" = {
            tooltip = false;
            format = "{:%H:%M}";
            format-alt = "{:%A, %B %d, %Y (%R)}";
          };
          "network" = {
            tooltip = false;
            format-ethernet = "󰶡 {bandwidthDownBits} 󰶣 {bandwidthUpBits}";
            format-wifi = "&#8195;{signalStrength}%";
            format-disconnected = "󰣼 ";
            on-click = "kitty nmtui";
          };
          "custom/screenshot" = {
            tooltip = false;
            format = "󱣴";
            on-click = "grim -g \"$(slurp -o -r -c '##ff0000ff')\" -t ppm - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png";
          };
          "custom/power" = {
            tooltip = false;
            format = "⤬";
            on-click = "wleave";
          };
        };
      };
      style = ''
        * {
          color: rgb(253, 237, 252);
          font-size: 14px;

          border: none;
          border-radius: 0;
          min-height: 0;
          margin: 1px 1px 0px 1px;
          padding: 0;
        }

        window#waybar {
          background: transparent;
        }

        tooltip {
          background: rgb(43, 48, 59);
        }

        tooltip * {
          color: rgb(253, 237, 252);
        }

        /*-----module groups----*/

        .modules-left {
          padding-left: 4px;
        }

        .modules-right {
          padding-right: 4px;
        }

        #clock,
        #battery,
        #cpu,
        #memory,
        #disk,
        #temperature,
        #backlight,
        #network,
        #pulseaudio,
        #wireplumber,
        #custom-media,
        #tray,
        #mode,
        #idle_inhibitor,
        #scratchpad,
        #mpd,
        #workspaces,
        #custom-screenshot,
        #custom-notification,
        #custom-power {
          padding: 0 10px;
          border-radius: 10px;
          background: rgba(20,20,26,0.85);
        }

        #custom-power {
          font-size: 14px;
          background: rgba(203, 166, 247, 0.85);
          color: rgba(20,20,26,0.85);
        }

        #workspaces button.active {
          border-bottom: 1.5px solid rgba(203, 166, 247, 1);
        }
      '';
    };
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };
  };

  services = {
    mako = {
      enable = true;
      defaultTimeout = 4500;
    };
    # flameshot.enable = true;
  };

  # Enable systemd target unit needed for flameshot
  # See [Unit tray.target not found](https://github.com/nix-community/home-manager/issues/2064) for more information
  # credit to user 'zeorin' for the workaround
  # systemd.user.targets.tray = {
  #   Unit = {
  #     Description = "Home Manager System Tray";
  #     Requires = ["graphical-session-pre.target"];
  #   };
  # };
}
