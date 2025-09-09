{
  programs = {
    git = {
      enable = true;
      userEmail = "admin@gama.pm";
      userName = "Gamayun Robakov";
      aliases = {
        # Basics
        s = "status -sb";
        a = "add";
        pl = "pull";
        ps = "push";
        b = "branch -v";
        ba = "branch -va";
        d = "diff --word-diff";
        ci = "commit";
        co = "checkout";
        cl = "clone";
        m = "merge";
        r = "remote";
        rb = "rebase";
        # Advanced
        l = "log --graph --decorate --pretty=oneline --abbrev-commit";
        la = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };
    gpg = {
      enable = true;
    };
  };
}
