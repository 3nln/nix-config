{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "github.com-personal" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519_personal";
      };

      "github.com-unical" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519_unical";
      };
    };
  };
}
