{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      # Personal GitHub (javohirtech@gmail.com)
      "gh-personal" = {
        hostname = "github.com";
        user = "git";
        identityFile = [ "~/.ssh/id_ed25519_personal" ];
      };

      # Work GitHub (javohir@unical.uz)
      "gh-unical" = {
        hostname = "github.com";
        user = "git";
        identityFile = [ "~/.ssh/id_ed25519_unical" ];
      };

      "gl-unical" = {
        hostname = "git.unical.uz";
        user = "git";
        identityFile = [ "~/.ssh/id_ed25519_unical" ];
      };
    };
  };
}
