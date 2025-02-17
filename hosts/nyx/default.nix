{
  # inputs,
  ...
}: {
  # Import system (NixOS) modules
  imports = [
    # To import from personal flake exports (modules/nixos):
    # outputs.nixosModules.<moduleName>

    # To import from other flakes:
    # inputs.<inputFlake>.nixosModules.<moduleName>

    # To import local modules:
    # ../../modules/nixos/<moduleName>
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

  gaming.enable = true;

  services.fwupd.enable = true;

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

  system.stateVersion = "23.11";
}
