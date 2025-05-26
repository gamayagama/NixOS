let
  myAliases = {
    ls = "eza";
    ll = "eza -lAh --group-directories-first --time-style='+%Y-%m-%d %H:%M' --total-size";
    llt = "eza -lAhT --group-directories-first --time-style='+%Y-%m-%d %H:%M' --total-size";
    ping = "ping -c 5";
    cat = "bat";
    catp = "bat --style=-grid,-numbers"
  };
in
{
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      autocd = true;
      shellAliases = myAliases;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    bat = {
      enable = true;
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
      extraOptions = [
        "--group-directories-first"
        "--colour=always"
        "--icons=auto"
        "--header"
      ];
    };
    tealdeer = {
      enable = true;
      settings = {
        display = {
          compact = true;
          use_pager = false;
        };
        updates = {
          auto_update = true;
        };
      };
    };
  };
}
