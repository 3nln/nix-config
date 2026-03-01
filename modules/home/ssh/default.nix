{
  config,
  pkgs,
  ...
}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "gh-personal" = {
        hostname = "github.com";
        user = "git";
        identityFile = ["~/.ssh/id_ed25519_personal"];
      };

      "gh-unical" = {
        hostname = "github.com";
        user = "git";
        identityFile = ["~/.ssh/id_ed25519_unical"];
      };

      "gl-unical" = {
        hostname = "git.unical.uz";
        user = "git";
        identityFile = ["~/.ssh/id_ed25519_unical"];
      };
    };
  };

  # Generate SSH keys if they don't exist
  home.activation.generateSSHKeys = config.lib.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh

    # Generate personal SSH key
    if [ ! -f ~/.ssh/id_ed25519_personal ]; then
      ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_personal -N "" -C "javohirtech@gmail.com"
      chmod 600 ~/.ssh/id_ed25519_personal
      chmod 644 ~/.ssh/id_ed25519_personal.pub
    fi

    # Generate unical SSH key
    if [ ! -f ~/.ssh/id_ed25519_unical ]; then
      ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_unical -N "" -C "javohir@unical.uz"
      chmod 600 ~/.ssh/id_ed25519_unical
      chmod 644 ~/.ssh/id_ed25519_unical.pub
    fi
  '';
}
