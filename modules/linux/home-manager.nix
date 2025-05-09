{
  config,
  pkgs,
  lib,
  ...
}: let
  user = "tdesilva";
  xdg_configHome = "/home/${user}/.config";
  nixRoot = "/home/tdesilva/.nix-profile";
  sharedPrograms = import ../shared/home-manager.nix {inherit config pkgs lib nixRoot;};
  sharedFiles = import ../shared/files.nix {inherit config pkgs;};
  additionalFiles = import ./files.nix {inherit user config pkgs;};
in {
  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages =
      [
        (pkgs.python3.withPackages (ppkgs: [
          ppkgs.setuptools
        ]))
      ]
      ++ pkgs.callPackage ./packages.nix {};
    file = lib.mkMerge [
      sharedFiles
      additionalFiles
    ];
    stateVersion = "21.05";
  };

  programs =
    sharedPrograms
    // {
    };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry;
  };
}
