{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    cleanTmpDir = true;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        editor = false;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  # Network settings
  networking = {
    hostName = "saphyr";

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    useDHCP = lib.mkDefault true;
    interfaces.wlo1.useDHCP = lib.mkDefault true;
  };

  fileSystems = {

    "/" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-label/SWAP"; }
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.bluetooth = {
    enable = true;
  };

  services.xserver = {
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        scrollMethod = "twofinger";
        naturalScrolling = true;
        disableWhileTyping = true;
      };
    };
  };

  # Enable thermald for cooling management
  services.thermald.enable = lib.mkDefault true;

  # Do not touch!
  system.stateVersion = "21.11";
}
