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

  programs.home-manager.enable = true;

  # Setup user, packages, programs
  # nix = {
  #   package = pkgs.nix;
  #   settings = {
  #     trusted-users = ["@admin" "${user}"];
  #     substituters = ["https://nix-community.cachix.org" "https://cache.nixos.org"];
  #     trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="];
  #   };

  #   gc = {
  #     user = "root";
  #     automatic = true;
  #     interval = {
  #       Weekday = 0;
  #       Hour = 2;
  #       Minute = 0;
  #     };
  #     options = "--delete-older-than 7d";
  #   };

  #   optimise = {
  #     automatic = true;
  #   };

  #   extraOptions = ''
  #     experimental-features = nix-command flakes
  #     keep-outputs = true
  #     keep-derivations = true
  #   '';
  # };

  # Load configuration that is shared across systems
  # environment.systemPackages = with pkgs;
  #   [
  #     # agenix.packages."${pkgs.system}".default
  #   ]
  #   ++ (import ../../modules/shared/packages.nix {inherit pkgs;});

  # fonts.packages = with pkgs; [
  #   nerd-fonts.jetbrains-mono
  # ];
}
