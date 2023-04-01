{ config, pkgs, ... }:

let
  mainUser = "fmrh";

in {
  users.users.${mainUser} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Fillip Holgersen";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
  };

  # Zsh being enabled in HM config is not recognised resulting in an error message
  # Enabled systemwide to solve this temporarily
  programs.zsh.enable = true;
}
