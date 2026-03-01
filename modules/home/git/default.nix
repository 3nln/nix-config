{
  programs.git = {
    enable = true;

    lfs.enable = true;

    ignores = [
      ".idea"
      "node_modules"
      ".DS_Store"
      "*.swp"
      "*~"
      "*#"
      ".#*"
    ];

    settings = {
      user = {
        name = "3nln";
        email = "javohirtech@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = false;
      push.autoSetupRemote = true;
    };

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
  };
}
