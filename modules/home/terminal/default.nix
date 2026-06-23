{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    # See available themes here:
    # https://github.com/kovidgoyal/kitty-themes/tree/master/themes
    # This option takes the file name of a theme, without the .conf suffix
    # themeFile = "GruvboxMaterialDarkHard";
    font = {
      name = "Hack";
      size = 11;
    };
    settings = {
      cursor_shape = "underline";
      shell_integration = "no-cursor";
      scrollback_fill_enlarged_window = "yes";
      show_hyperlink_targets = "yes";
      enable_audio_bell = "no";
      window_padding_width = "6";
      inactive_text_alpha = "0.5";
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      background_opacity = "0.9";
      background_tint = "10";
      background_blur = "0";
      dynamic_background_opacity = "yes";
      notify_on_cmd_finish = "invisible";

      foreground = "#fff2e5";
      background = "#0f0808";
      color0 = "#1a0900";
      color8 = "#ffe6cc";
      color1 = "#bf6443";
      color9 = "#dc8c63";
      color2 = "#48734f";
      color10 = "#669e6f";
      color3 = "#db9448";
      color11 = "#e4af77";
      color4 = "#4a7882";
      color12 = "#5b8892";
      color5 = "#752f2f";
      color13 = "#b36161";
      color6 = "#793e2a";
      color14 = "#aa573c";
      color7 = "#ead0c3";
      color15 = "#ffe6cc";
    };
  };
}
