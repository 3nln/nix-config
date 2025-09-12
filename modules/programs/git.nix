{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "3nln";
    userEmail = "javohirtech@gmail.com";

    includes = [
      {
        condition = "gitdir:~/work/";
        contents.user = {
          name = "Neo (Work)";
          email = "javohir@unical.uz";
        };
      }
    ];

    extraConfig = {
      init.defaultBranch = "main";
      core.sshCommand = "ssh -i ~/.ssh/id_ed25519_personal -F /dev/null";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
