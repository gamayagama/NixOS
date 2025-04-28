{pkgs, ...}:

{
  programs.thunderbird = {
    enable = true;
    package = pkgs.thunderbird-latest;
    profiles.default = {
      isDefault = true;
      search = {
        default = "searx";
        engines = {
          # "searx" = {
          #   urls = [{ template = "https://search.rhscz.eu/search?q={searchTerms}"; }];
          # };
        };
      };
    };
  };
}
