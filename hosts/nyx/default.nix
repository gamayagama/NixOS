{ config, lib, pkgs, modulesPath, system, ... }:

{
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

    # Hardware configuration
    ./hardware.nix 
    # (modulesPath + "/installer/scan/not-detected.nix")
  ];

  services.fwupd.enable = true;

  # boot.initrd = {
  #   availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  #   kernelModules = [ ];
  # };
  # boot.kernelModules = [ "kvm-intel" ];
  # boot.extraModulePackages = [ ];
  #
  # fileSystems."/" =
  #   { device = "/dev/disk/by-uuid/e6b15647-3bd6-4329-bf86-5258009ff36c";
  #     fsType = "ext4";
  #   };
  #
  # fileSystems."/boot" =
  #   { device = "/dev/disk/by-uuid/DBC7-E7AC";
  #     fsType = "vfat";
  #     options = [ "fmask=0022" "dmask=0022" ];
  #   };
  #
  # swapDevices = [ ];
  #
  # networking.useDHCP = lib.mkDefault true;
  #
  # nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

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
