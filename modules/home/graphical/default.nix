{
  inputs,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    settings = {
      "$mod" = "SUPER";
      bind =
        [
          "$mod_SHIFT, Return, exec, kitty"
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
    plugins = [];
    systemd = {
      enable = true;
      variables = ["--all"];
      # enableXdgAutostart = true;
    };
    xwayland.enable = true;
  };

  services = {
    flameshot.enable = true;
  };

  # Enable systemd target unit needed for flameshot
  # See [Unit tray.target not found](https://github.com/nix-community/home-manager/issues/2064) for more information
  # credit to user 'zeorin' for the workaround
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };
}
