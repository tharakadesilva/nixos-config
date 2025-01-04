{
  config,
  inputs,
  lib,
  pkgs,
  agenix,
  ...
}: let
  user = "tdesilva";
  keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOk8iAnIaa1deoc7jw8YACPNVka1ZFJxhnU4G74TmS+p"];
in {
  imports = [
    # ../../modules/linux/secrets.nix
    ../../modules/linux/home-manager.nix
    ../../modules/shared
    # agenix.nixosModules.default
  ];

  nix = {
    package = pkgs.nixVersions.git;
    settings.trusted-users = ["@admin" "${user}"];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Setup user, packages, programs
  nix = {
    package = pkgs.nix;
    settings = {
      trusted-users = ["@admin" "${user}"];
      substituters = ["https://nix-community.cachix.org" "https://cache.nixos.org"];
      trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="];
    };

    gc = {
      user = "tdesilva";
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 7d";
    };

    optimise = {
      automatic = true;
    };

    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  programs.home-manager.enable = true;
}
