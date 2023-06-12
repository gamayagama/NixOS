{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      timeout = 3;
    };

    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a4b6ec18-efad-4fc8-9a4a-673a0e703727";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/A0E6-8F11";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/3e116837-a221-4615-a072-367d984a1e65"; }
    ];


  networking = {
    hostName = "terra";

    useDHCP = lib.mkDefault true;
    # interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Nvidia Graphics
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  # Do not touch!
  system.stateVersion = "22.11";
}
