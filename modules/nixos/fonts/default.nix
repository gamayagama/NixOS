{pkgs, ...}: {
  fonts.packages = with pkgs; [
    atkinson-hyperlegible
    (
      nerdfonts.override
      {
        fonts = ["FiraCode" "Hack"];
      }
    )
  ];
}
