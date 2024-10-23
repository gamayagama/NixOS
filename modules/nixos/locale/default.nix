let
  myLocale = "en_US.UTF-8";
in {
  time.timeZone = "Europe/Copenhagen";
  i18n = {
    defaultLocale = "${myLocale}";
    extraLocaleSettings = {
      LC_ADDRESS = "${myLocale}";
      LC_IDENTIFICATION = "${myLocale}";
      LC_MEASUREMENT = "${myLocale}";
      LC_MONETARY = "${myLocale}";
      LC_NAME = "${myLocale}";
      LC_NUMERIC = "${myLocale}";
      LC_PAPER = "${myLocale}";
      LC_TELEPHONE = "${myLocale}";
      LC_TIME = "${myLocale}";
    };
  };
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
