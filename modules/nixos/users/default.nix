{ config, pkgs, username, fullName, ... }:

{
  users.users = {
    ${username} = {
      isNormalUser = true;
      description = "${fullName}";
      extraGroups = [ "wheel" "networkmanager" ];
      shell = pkgs.zsh;
    };
  };
  programs.zsh.enable = true;
}
