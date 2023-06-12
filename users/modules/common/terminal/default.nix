{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      window = {
        opacity = 0.9;
        padding = {
          x = 6;
          y = 6;
        };
      };
      cursor = {
        style = {
          shape = "Underline";
          blinking = "On";
        };
      };
      colors = {
        cursor = {
          text = "#a89984";
          cursor = "#ebdbb2";
        };
        primary = {
          background = "#282828";
          foreground = "#ebdbb2";
        };
        normal = {
          black   = "#282828";
          red     = "#cc241d";
          green   = "#98971a";
          yellow  = "#d79921";
          blue    = "#458588";
          magenta = "#b16286";
          cyan    = "#689d6a";
          white   = "#a89984";
        };
        bright = {
          black   = "#928374";
          red     = "#9d0006";
          green   = "#79740e";
          yellow  = "#b57614";
          blue    = "#076678";
          magenta = "#8f3f71";
          cyan    = "#427b58";
          white   = "#ebdbb2";
        };
      };
      font = {
        normal = {
          family = "Hasklug Nerd Font";
          style = "regular";
        };
        bold = {
          family = "Hasklug Nerd Font";
          style = "bold";
        };
        italic = {
          family = "Hasklug Nerd Font";
          style = "italic";
        };
        bold_italic = {
          family = "Hasklug Nerd Font";
          style = "Bold Italic";
        };
        size = 11;
      };
    };
  };
}
