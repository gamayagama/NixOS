{
  programs = {
    git = {
      enable = true;
      userEmail = "admin@gama.pm";
      userName = "Gamayun Robakov";
      aliases = {
        # Basics
        g = "git";

        gs = "git status -sb";
        ga = "git add";
        gpl = "git pull";
        gpu = "git push";
        gb = "git branch -v";
        gba = "git branch -va";
        gd = "git diff --word-diff";
        gci = "git commit";
        gco = "git checkout";
        gcl = "git clone";
        gm = "git merge";
        gr = "git remote";
        grb = "git rebase";
        # Advanced
        gl = "log --graph --decorate --pretty=oneline --abbrev-commit";
        gla = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
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
