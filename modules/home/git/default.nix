{
  programs.git = {
    enable = true;
    userName = "3nln";
    userEmail = "javohirtech@gmail.com";

    includes = [
      # Personal repos (anything under ~/projects or ~/personal)
      {
        condition = "gitdir:~/projects/";
        contents.user = {
          name = "Neo";
          email = "javohirtech@gmail.com";
        };
        contents.core = {
          sshCommand = "ssh -i ~/.ssh/id_ed25519_personal -F /dev/null";
        };
      }

      # Work repos (anything under ~/work)
      {
        condition = "gitdir:~/work/";
        contents.user = {
          name = "Neo (Work)";
          email = "javohir@unical.uz";
        };
        contents.core = {
          sshCommand = "ssh -i ~/.ssh/id_ed25519_unical -F /dev/null";
        };
      }
    ];

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
