{ pkgs }:

with pkgs; [
  # General packages for development and system management
  bat
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
  ibazel
  jq
  maven
  neovim
  node
  nodePackages.eas-cli
  nodePackages.npm
  openjdk
  pinentry
  procs
  python3
  ripgrep
  rm-improved
  rsync
  supabase
  thefuck
  tmux
  zoxide
  zsh
]
