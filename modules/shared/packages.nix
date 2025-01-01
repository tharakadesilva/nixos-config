{ pkgs }:

with pkgs; [
  # General packages for development and system management
  awscli
  bat
  bazel-watcher
  bazelisk
  bottom
  buildifier
  bun
  cowsay
  delta
  docker
  docker-compose
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
  oh-my-zsh
  openjdk
  procs
  python3
  ripgrep
  rm-improved
  rsync
  starship
  supabase-cli
  thefuck
  tmux
  zoxide
  zsh
]
