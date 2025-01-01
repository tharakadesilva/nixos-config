{ config, pkgs, agenix, secrets, ... }:

let user = "tharakadesilva"; in
{
  age.identityPaths = [
    "/Users/${user}/.ssh/id_ed25519"
  ];
}
