{
  config,
  pkgs,
  agenix,
  secrets,
  ...
}: let
  user = "tharakadesilva";
in {
  age.identityPaths = [
    "/Users/${user}/.ssh/id_ed25519"
  ];

  age.secrets."github-ssh-key" = {
    symlink = true;
    path = "/Users/${user}/.ssh/id_github";
    file = "${secrets}/github-ssh-key.age";
    mode = "600";
    owner = "${user}";
    group = "staff";
  };

  age.secrets."github-gpg-key" = {
    symlink = false;
    path = "/Users/${user}/.ssh/gpg_github";
    file = "${secrets}/github-gpg-key.age";
    mode = "600";
    owner = "${user}";
  };
}
