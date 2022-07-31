{ config, pkgs, ... }:

{
  imports = [
    ./browser
    ./communication
    ./keyboard
    ./music
    ./productivity
    ./IDE
  ];
}
