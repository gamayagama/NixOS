{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    gaming.enable = lib.mkEnableOption "Enables the gaming module";
  };

  config = lib.mkIf config.gaming.enable {
    # Enable openGPL and GPU drivers
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    programs = {
      # Optimise Linux system performance on demand
      gamemode.enable = true;
      # Steam configuration
      steam = {
        enable = true;

        # Open ports for various features
        # remotePlay.openFirewall = true;
        # localNetworkGameTransfers.openFirewall = true;
        # dedicatedServer.openFirewall = true;

        extraCompatPackages = with pkgs; [ proton-ge-bin ];

        # Run games in micro compositor for better upscaling in some cases
        gamescopeSession.enable = true;

        # load extest library, used for Steam Input on Wayland
        # extest.enable = true;
      };
    };
    # Install Heroic launcher
    environment.systemPackages = with pkgs; [
      heroic
      protontricks
    ];
  };
}
