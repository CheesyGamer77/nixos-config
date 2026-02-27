{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "CaseyCodes";
        email = "43181046+CheesyGamer77@users.noreply.github.com";
      };

      alias = {
        aliases = "config --get-regexp alias";
        branches = "branch --all";
        cp = "cherry-pick";
        remotes = "remote --verbose";
        tags = "tag -l";
        undo = "reset HEAD~";
      };

      init.defaultBranch = "main";
    };
  };
}
