{
  programs = {
    git = {
      enable = true;
      settings = {
        init = { defaultBranch = "main"; };
        user = {
          email = "admin@gama.pm";
          name = "gamayagama";
        };
        alias = {
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
      };
    };
    gpg = {
      enable = true;
    };
  };
}
