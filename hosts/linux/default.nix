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

  nix.enable = false;

  programs.home-manager.enable = true;
}
