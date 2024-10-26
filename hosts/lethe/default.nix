{
  imports = [
    ../../modules/nixos/networking
    ../../modules/nixos/ssh
    ../../modules/nixos/nix
    ../../modules/nixos/locale
    ../../modules/nixos/fonts
    ../../modules/nixos/graphical
    ../../modules/nixos/sound
    ../../modules/nixos/gaming

    # Hardware configuration
    ./hardware.nix
  ];

  # Enable gaming module
  gaming.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
  };

  system.stateVersion = "24.05";
}
