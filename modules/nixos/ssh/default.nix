{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      #TODO: configure authorizedKeys and disable PasswordAuthentication
      # PasswordAuthentication = false;
    };
  };
}
