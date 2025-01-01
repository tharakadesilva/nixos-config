# NixOS Config

This is my NixOS configuration. If you want to create your own, check out [dustinlyons/nixos-config](https://github.com/dustinlyons/nixos-config) which was used as a template for this configuration.

## Installing

### 1. Install dependencies
```sh
xcode-select --install
```

### 2. Install Nix
Thank you for the [installer](https://zero-to-nix.com/concepts/nix-installer), [Determinate Systems](https://determinate.systems/)!
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
After installation, open a new terminal session to make the `nix` executable available in your `$PATH`. You'll need this in the steps ahead.
