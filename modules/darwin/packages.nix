{pkgs}:
with pkgs; let
  shared-packages = import ../shared/packages.nix {inherit pkgs;};
in
  shared-packages
  ++ [
    _1password-cli
    pinentry_mac
    terminal-notifier
  ]
