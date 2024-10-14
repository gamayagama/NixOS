{ config, pkgs, ... }:

{
  nix = {
    settings = {
      auto-optimise-store = true;
      allowed-users = [ "@wheel" ];
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
