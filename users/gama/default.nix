{ inputs, pkgs, username, ... }:
{
  # Import other home-manager modules
  
  # To import from personal flake exports (modules/home-manager):
  # outputs.homeManagerModules.<moduleName>

  # To import from other flakes (from flake inputs):
  # inputs.<inputFlake>.homeManagerModules.<moduleName>
  # For an example, see nix-colors below: 
  # https://github.com/Misterio77/nix-colors/tree/b01f024090d2c4fc3152cd0cf12027a7b8453ba1
  
  # To import local modules:
  # ../../modules/home/<moduleName>
  imports = [
    ../../modules/home/shell
    ../../modules/home/terminal
    ../../modules/home/editor
    ../../modules/home/browser
    ../../modules/home/development
    ../../modules/home/graphical
  ];

  nixpkgs = {
    overlays = [];
    config = {};
  };

  # Install extra packages
  # This is needed for packages without home-manager config options
  home.packages = with pkgs; [
    libreoffice
    obsidian
    beeper
    protonvpn-gui
    bottom
    mpv
    nicotine-plus
    picard
    gapless
    # spek
    yazi
    teams-for-linux
    geogebra
    speedcrunch
    pandoc
    freetube
    proton-pass
    qbittorrent
    discord
  ];

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.11";
  };

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # Reload system units when changing configurations
  # Alternative options: "suggest" or "legacy"
  systemd.user.startServices = "sd-switch";
}
