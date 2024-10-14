{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration  = true;
    # See available themes here:
    # https://github.com/kovidgoyal/kitty-themes/tree/master/themes
    # This option takes the file name of a theme, without the .conf suffix
    themeFile = "GruvboxMaterialDarkHard";
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
      background_opacity = "0.8";
      background_blur = "1";
      dynamic_background_opacity = "yes";
      notify_on_cmd_finish = "invisible";
    };
  };
}
