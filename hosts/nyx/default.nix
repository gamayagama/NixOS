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

    # Hardware scan
    (modulesPath + "/installer/scan/not-detected.nix") 
  ];

  networking = {
    useDHCP = lib.mkDefault true;
    # networking.interfaces.eno2.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;
  };

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

    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" =
      { device = "/dev/disk/by-uuid/091e4431-9ec8-49ef-b2e6-46ab667f6009";
        fsType = "ext4";
      };

    "/boot" =
      { device = "/dev/disk/by-uuid/0195-6FA6";
        fsType = "vfat";
      };
  };
  swapDevices =
    [ { device = "/dev/disk/by-uuid/0a36c43d-d94c-44a6-a3e5-1714c9701c82"; } ];

  nixpkgs.hostPlatform = lib.mkDefault "${system}";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "23.11";
}
