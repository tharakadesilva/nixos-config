{ pkgs }:

with pkgs; [
  # General packages for development and system management
  bat
  bazel-watcher
  bazelisk
  bottom
  buildifier
  bun
  cowsay
  delta
  docker
  duf
  dust
  eza
  fd
  ffmpeg
  git
  git-lfs
  gnupg
  go
  jq
  maven
  neovim
  nodejs_22
  nodePackages.eas-cli
  nodePackages.npm
  openjdk
  pinentry
  procs
  python3
  ripgrep
  rm-improved
  rsync
  supabase-cli
  thefuck
  tmux
  zoxide
  zsh
]
