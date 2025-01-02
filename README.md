# NixOS Config

This is my NixOS configuration. If you want to create your own, check out [dustinlyons/nixos-config](https://github.com/dustinlyons/nixos-config) which was used as a template for this configuration.

## Installing

### 1. Install dependencies

```sh
xcode-select --install
```

### 2. Enable full disk access for Terminal

Settings > Privacy & Security > Full Disk Access > + > Terminal > Add Access

### 3. Install Nix

Thank you for the [installer](https://zero-to-nix.com/concepts/nix-installer), [Determinate Systems](https://determinate.systems/)!

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
After installation, open a new terminal session to make the `nix` executable available in your `$PATH`. You'll need this in the steps ahead.

### 4. Copy the NIX SSH keys from USB

The keys `id_ed25519` and `id_ed25519_agenix` need to be saved in the `~/.ssh` directory.

### 5. Clone the Repository 

This should be done in the `~/` directory.

```sh
git clone https://github.com/tharakadesilva/nixos-config.git
```

### 6. Run the build script

```sh
nix run .#build-switch
```

## Manual Steps

1. Set up the second fingerprint

Settings > Touch ID & Password > Add Fingerprint

2. Enable unlock with Apple Watch

Settings > Touch ID & Password > Unlock with Apple Watch

3. Grant full disk access to Warp

Settings > Privacy & Security > Full Disk Access > + > Warp > Add Access

4. Set up Apple Intelligence & Siri

Settings > Privacy & Security > Apple Intelligence & Siri > Enable

<!-- TODO set the info and also how to set up chatgpt -->

5. Set up Warp

Settings > Appearance > Prompt > Shell Prompt (PS1)
Settings > Appearance > Text > Terminal Font > JetBrainsMono Nerd Font
Settings > Features > Terminal > Use Audible Bell > On
