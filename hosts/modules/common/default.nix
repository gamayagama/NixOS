{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./adb
      ./audio
      ./fonts
      ./locale
      ./networking
      ./nix
      ./security
      ./ssh
      ./users
      ./virtualisation
      ./xserver
    ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.flatpak.enable = true;

  environment = {

    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    defaultPackages = lib.mkForce [];

    # System packages
    systemPackages = with pkgs; [
      wget
      ranger
      xarchiver
      p7zip
      ripgrep
      fd
      tor-browser-bundle-bin
      whatsapp-for-linux
      nicotine-plus
      tagger
    ];
  };
}
