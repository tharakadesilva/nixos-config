{
  config,
  pkgs,
  lib,
  ...
}: let
  user = "tdesilva";
  xdg_configHome = "/home/${user}/.config";
  sharedPrograms = import ../shared/home-manager.nix {inherit config pkgs lib;};
  sharedFiles = import ../shared/files.nix {inherit config pkgs;};
  additionalFiles = import ./files.nix {inherit user config pkgs;};
in {
  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = pkgs.callPackage ./packages.nix {};
    file = lib.mkMerge [
      sharedFiles
      additionalFiles
    ];
    stateVersion = "21.05";
  };

  programs =
    sharedPrograms
    // {
      git.userName = "Taraka De Silva";
      git.userEmail = "taraka.desilva@booking.com";
    };
}
