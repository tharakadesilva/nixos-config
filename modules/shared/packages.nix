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
  docker
  docker-compose
  duf
  dust
  eza
  fd
  ffmpeg
  gnupg
  go
  jq
  maven
  neovim
  nodejs_22
  nodePackages.eas-cli
  nodePackages.npm
  oh-my-zsh
  openjdk
  procs
  python3
  ripgrep
  rm-improved
  rsync
  supabase-cli
  thefuck
  tmux
  zoxide
]
