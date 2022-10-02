{ config, pkgs, ... }:

{
  imports = [
    ./development
  ];


  home.packages = with pkgs; [
    bitwarden
    qbittorrent
    spotify
    protonvpn-gui
  ];
}
