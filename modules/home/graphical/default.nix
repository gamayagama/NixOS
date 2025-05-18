{
  inputs,
  pkgs,
  ...
}:
let
  startupScript = pkgs.writeShellScriptBin "start" ''
    ${pkgs.swww}/bin/swww-daemon &
    ${pkgs.mako}/bin/mako &
    ${pkgs.waybar}/bin/waybar &
    systemctl --user enable --now hyprpolkitagent.service
    wl-paste --watch cliphist store
    udiskie &

    sleep 1

    ${pkgs.swww}/bin/swww img ${./wallpaper.png} &
  '';
in
{
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
      pavucontrol
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
    plugins = [ ];
    systemd = {
      enable = false; # This setting conflicts with uwsm
      variables = [ "--all" ];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
    settings = {
      # Initiate various needed programs/utils
      exec-once = [
        "uwsm finalize"
        "${startupScript}/bin/start"
      ];

      # General settings
      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 1;
        layout = "master";
      };

      animations = {
        animation = [
          "windows, 1, 2, default, popin 80%"
          "border, 1, 3, default"
          "fade, 1, 1, default"
          "workspaces, 1, 2, default"
        ];
      };

      device = {
        name = "asue120b:00-04f3:31c0-touchpad";
        natural_scroll = true;
      };

      # Misc.
      misc = {
        # disable_hyprland_logo = true; # DO NOT ENABLE: Causes issues rendering various programs.
        disable_splash_rendering = true;
      };

      # Decorations
      decoration = {
        rounding = 4;
        blur = {
          size = 12;
          passes = 2;
        };
      };

      # Layouts
      master = {
        orientation = "center";
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Bindings
      "$mod" = "SUPER";
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
          builtins.concatLists (
            builtins.genList (
              i:
              let
                ws = i + 1;
              in
              [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            ) 9
          )
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

          modules-left = [ "hyprland/workspaces" ];
          modules-center = [ "clock" ];
          modules-right = [
            "custom/screenshot"
            "network"
            "pulseaudio"
            "battery"
            "custom/power"
          ];

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
            persistent-workspaces = {
              "*" = 9;
            }; # Show all workspaces
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
          "pulseaudio" = {
            format = "{icon}&#8195;{volume}";
            format-bluetooth = "&#8195;{icon}&#8195;{volume}";
            format-icons = {
              default = [
                " "
                " "
              ];
            };
            on-click = "pavucontrol";
          };
          "battery" = {
            interval = 60;
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon}&#8195;{capacity}";
            format-icons = [
              " "
              " "
              " "
              " "
              " "
            ];
            max-length = 25;
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
      defaultTimeout = "4500";
    };
  };
}
