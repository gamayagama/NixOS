{
  pkgs,
  inputs,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Hint Electron apps to use Wayland
  environment.variables.NIXOS_OZONE_WL = "1";

  services = {
    displayManager = {
      ly.enable = true;
      lemurs = {
        enable = false;
        settings = {
          focus_behaviour = "password";
          background = {
            show_background = true;
            style = {
              color = "black";
              show_border = false;
            };
          };
          power_controls.base_entries = [
            {
              hint = "Shutdown";
              hint_color = "dark gray";
              hint_modifiers = "";
              key = "F1";
              cmd = "systemctl poweroff -l";
            }
            {
              hint = "Reboot";
              hint_color = "dark gray";
              hint_modifiers = "";
              key = "F2";
              cmd = "systemctl reboot -l";
            }
          ];
          environment_switcher = {
            show_neighbours = false;

            mover_color = "dark gray";
            mover_modifiers = "";
            mover_color_focused = "dark gray";
            mover_modifiers_focused = "bold";
            left_mover = "<";
            right_mover = ">";

            selected_color = "light magenta";
            selected_modifiers = "underlined";
            selected_color_focused = "light magenta";
            selected_modifiers_focused = "bold";
            max_display_length = 32;
          };
          username_field = {
            remember = true;
            style = {
              title = "User";
              title_color = "dark gray";
              content_color = "light magenta";
              title_color_focused = "dark gray";
              content_color_focused = "light magenta";
              show_border = true;
              border_color = "dark gray";
              border_color_focused = "dark gray";
            };
          };
          password_field.style = {
            title_color = "dark gray";
            content_color = "light magenta";
            title_color_focused = "dark gray";
            content_color_focused = "light magenta";
            show_border = true;
            border_color = "dark gray";
            border_color_focused = "dark gray";
          };
        };
      };
    };
    desktopManager.plasma6.enable = true;
  };
}
