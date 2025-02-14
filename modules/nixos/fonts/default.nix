{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    atkinson-hyperlegible
    nerd-fonts.fira-code
    nerd-fonts.hack
  ];
}
