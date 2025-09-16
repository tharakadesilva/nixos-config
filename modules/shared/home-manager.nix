{
  config,
  pkgs,
  lib,
  nixRoot,
  ...
}: let
  name = "Tharaka De Silva";
  user = "tharakadesilva";
  email = "tharaka.uo@gmail.com";
in {
  awscli = {
    enable = true;
    settings = {
      default = {
        profile = "default";
        region = "eu-west-3"; # Paris
      };
    };
  };

  direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  git = {
    enable = true;
    userName = name;
    userEmail = email;
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        hyperlinks-file-link-format = "cursor://file/{path}:{line}";
      };
    };
    lfs = {
      enable = true;
    };
    signing = {
      key = "8327EC2441042FF8";
      signByDefault = true;
    };
    extraConfig = {
      branch.sort = "-committerdate";
      checkout.defaultRemote = "origin";
      column.ui = "auto";
      commit.verbose = true;
      core = {
        editor = "cursor -w";
        autocrlf = "input";
        fsmonitor = true;
        untrackedCache = true;
      };
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };
      feature = {
        experimental = true;
        manyFiles = true;
      };
      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };
      help.autocorrect = "prompt";
      init.defaultBranch = "main";
      merge.conflictStyle = "zdiff3";
      pull.rebase = true;
      push = {
        default = "simple";
        autoSetupRemote = true;
      };
      rebase = {
        autoStash = true;
        autoSquash = true;
        updateRefs = true;
      };
      rerere = {
        enabled = true;
        autoupdate = true;
      };
      tag.sort = "version:refname";
      transfer.fsckObjects = true;
      url."git@github.com:".insteadOf = "https://github.com/";
    };
  };

  gpg = {
    enable = true;
    publicKeys = [
      {
        source = "/Users/${user}/.ssh/gpg_github";
        trust = 5;
      }
    ];
  };

  ssh = {
    enable = true;
    includes = [
      (
        lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (
        lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (
            lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "/home/${user}/.ssh/id_github"
          )
          (
            lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "/Users/${user}/.ssh/id_github"
          )
        ];
      };
    };
  };

  starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "$os"
        "$directory"
        # version control
        "$fossil_branch"
        "$fossil_metrics"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$hg_branch"
        "$pijul_channel"
        "$character"
      ];

      right_format = lib.concatStrings [
        # system
        "$battery"
        "$cmd_duration"
        "$custom"
        "$direnv"
        "$env_var"
        "$username"
        "$hostname"
        "$jobs"
        "$localip"
        "$memory_usage"
        "$nats"
        "$shell"
        "$shlvl"
        "$status"
        "$sudo"
        "$time"
        "$vcsh"
        # cloud
        "$aws"
        "$azure"
        "$gcloud"
        "$openstack"
        # containers
        "$container"
        "$docker_context"
        "$kubernetes"
        "$singularity"
        # languages
        "$c"
        "$cmake"
        "$cobol"
        "$crystal"
        "$daml"
        "$dart"
        "$deno"
        "$dotnet"
        "$elixir"
        "$elm"
        "$erlang"
        "$fennel"
        "$gleam"
        "$golang"
        "$gradle"
        "$haskell"
        "$haxe"
        "$helm"
        "$java"
        "$julia"
        "$kotlin"
        "$lua"
        "$meson"
        "$nim"
        "$nodejs"
        "$ocaml"
        "$opa"
        "$perl"
        "$php"
        "$pulumi"
        "$purescript"
        "$python"
        "$quarto"
        "$raku"
        "$red"
        "$rlang"
        "$ruby"
        "$rust"
        "$scala"
        "$solidity"
        "$swift"
        "$terraform"
        "$typst"
        "$vagrant"
        "$vlang"
        "$zig"
        # package managers
        "$buf"
        "$conda"
        "$nix_shell"
        "$package"
        "$spack"
      ];

      command_timeout = 5000; # In large repos, commands such as `git status` can take a while to run.

      directory = {
        fish_style_pwd_dir_length = 1;
        substitutions = {
          "~/git_tree" = "";
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };
      };

      git_status = {
        ahead = "[⇡\${count}](italic green)";
        behind = "[⇣\${count}](italic red)";
        conflicted = "[~\${count}](italic bright-magenta)";
        deleted = "[x\${count}](italic red)";
        diverged = "[⇕ ⇡\${ahead_count} ⇣\${behind_count}](italic bright-magenta)";
        modified = "[!\${count}](italic yellow)";
        renamed = "[»\${count}](italic bright-blue)";
        staged = "[+\${count}](italic bright-cyan)";
        stashed = "[=\${count}](italic white)";
        untracked = "[?\${count}](italic bright-yellow)";
      };

      hostname = {
        format = "[$ssh_symbol$hostname]($style) ";
      };

      kubernetes = {
        disabled = false;
      };

      time = {
        disabled = false;
      };

      username = {
        format = "[$user]($style) @";
      };

      os = {
        disabled = false;
        format = "[$symbol]($style) ";
        symbols = {
          Alpaquita = "";
          Alpine = "";
          AlmaLinux = "";
          Amazon = "";
          Android = "";
          Arch = "";
          Artix = "";
          CentOS = "";
          Debian = "";
          DragonFly = "";
          Emscripten = "";
          EndeavourOS = " ";
          Fedora = "";
          FreeBSD = "";
          Garuda = "󰛓";
          Gentoo = "";
          HardenedBSD = "󰞌";
          Illumos = "󰈸";
          Kali = "";
          Linux = "";
          Mabox = "";
          Macos = "";
          Manjaro = "";
          Mariner = "";
          MidnightBSD = "";
          Mint = "";
          NetBSD = "";
          NixOS = "";
          OpenBSD = "󰈺";
          openSUSE = "";
          OracleLinux = "󰌷";
          Pop = "";
          Raspbian = "";
          Redhat = "";
          RedHatEnterprise = "";
          RockyLinux = "";
          Redox = "󰀘";
          Solus = "󰠳";
          SUSE = "";
          Ubuntu = "";
          Unknown = "";
          Void = "";
          Windows = "󰍲";
        };
      };

      aws = {
        symbol = "";
      };
      buf = {
        symbol = "";
      };
      c = {
        symbol = "";
      };
      conda = {
        symbol = "";
      };
      crystal = {
        symbol = "";
      };
      dart = {
        symbol = "";
      };
      docker_context = {
        symbol = "";
      };
      elixir = {
        symbol = "";
      };
      elm = {
        symbol = "";
      };
      erlang = {
        symbol = "ⓔ";
      };
      fennel = {
        symbol = "";
      };
      fossil_branch = {
        symbol = "";
      };
      git_branch = {
        symbol = "";
      };
      git_commit = {
        tag_symbol = "";
      };
      golang = {
        symbol = "";
      };
      gradle = {
        symbol = "";
      };
      guix_shell = {
        symbol = "";
      };
      haskell = {
        symbol = "";
      };
      haxe = {
        symbol = "";
      };
      hg_branch = {
        symbol = "";
      };
      hostname = {
        ssh_symbol = "";
      };
      java = {
        symbol = "";
      };
      julia = {
        symbol = "";
      };
      kotlin = {
        symbol = "";
      };
      lua = {
        symbol = "";
      };
      memory_usage = {
        symbol = "󰍛";
      };
      meson = {
        symbol = "󰔷";
      };
      nim = {
        symbol = "󰆥";
      };
      nix_shell = {
        symbol = "";
      };
      nodejs = {
        symbol = "";
      };
      ocaml = {
        symbol = "";
      };
      package = {
        symbol = "󰏗";
      };
      perl = {
        symbol = "";
      };
      php = {
        symbol = "";
      };
      pijul_channel = {
        symbol = "";
      };
      pulumi = {
        symbol = "🧊";
      };
      python = {
        symbol = "";
      };
      rlang = {
        symbol = "󰟔";
      };
      ruby = {
        symbol = "";
      };
      rust = {
        symbol = "󱘗";
      };
      scala = {
        symbol = "";
      };
      swift = {
        symbol = "";
      };
      typst = {
        symbol = "t";
      };
      zig = {
        symbol = "";
      };
    };
  };

  tealdeer = {
    enable = true;
    settings = {
      display = {
        compact = false;
        use_pager = true;
      };
      updates = {
        auto_update = true;
        auto_update_interval_hours = 24;
      };
    };
  };

  zsh = {
    enable = true;

    history = {
      ignorePatterns = [
        "pwd *"
        "ls *"
        "eza *"
        "cd *"
      ];
      save = 100000;
      size = 100000;
    };

    oh-my-zsh = {
      enable = true;
      extraConfig = ''
        # Uncomment the following line to display red dots whilst waiting for completion.
        # You can also set it to another string to have that shown instead of the default red dots.
        # e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
        # Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
        COMPLETION_WAITING_DOTS="true"

        zstyle ':omz:plugins:alias-finder' autoload yes
        zstyle ':omz:plugins:alias-finder' longer yes
        zstyle ':omz:plugins:alias-finder' exact yes
        zstyle ':omz:plugins:alias-finder' cheaper yes
      '';
      plugins = [
        "alias-finder"
        "aws"
        "bazel"
        "bun"
        "colored-man-pages"
        "command-not-found"
        "common-aliases"
        "copyfile"
        "copypath"
        "dircycle"
        "dirhistory"
        "docker"
        "docker-compose"
        "encode64"
        "extract"
        "gcloud"
        "git"
        "golang"
        "gradle"
        "helm"
        "history"
        "istioctl"
        "jsontools"
        "kubectl"
        "macos"
        "mvn"
        "node"
        "npm"
        "pip"
        "procs"
        "python"
        "rsync"
        "rust"
        "safe-paste"
        "screen"
        "ssh"
        "terraform"
        "tmux"
        "universalarchive"
        "urltools"
        "vscode"
        "xcode"
        "yarn"
        "yum"
        "zoxide"
      ];
    };

    autosuggestion = {
      enable = true;
    };

    syntaxHighlighting = {
      enable = true;
    };

    initContent = lib.mkBefore ''
      if [[ -f ${nixRoot}/etc/profile.d/nix-daemon.sh ]]; then
        . ${nixRoot}/etc/profile.d/nix-daemon.sh
        . ${nixRoot}/etc/profile.d/nix.sh
      fi

      fpath+=${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/zsh-completions/src
    '';

    logoutExtra = ''
      setopt norcs
    '';

    envExtra = ''
      export ANDROID_HOME=$HOME/Library/Android/sdk
      export ARCHFLAGS="-arch $(uname -m)"
      export COREPACK_ENABLE_AUTO_PIN=0
      export EDITOR="cursor"
      export LANG=en_US.UTF-8
      export LC_ALL=en_US.UTF-8
      export GRAAL_HOME=${pkgs.graalvmPackages.graalvm-oracle_25-ea}
      export JAVA_HOME=${pkgs.graalvmPackages.graalvm-oracle_25-ea}

      export PATH=$PATH:$ANDROID_HOME/emulator
      export PATH=$PATH:$ANDROID_HOME/platform-tools
      export PATH=$PATH:$HOME/go/bin
      export PATH=$PATH:$HOME/.local/bin
      export PATH=$PATH:$HOME/.bun/bin
    '';

    shellAliases = {
      cat = "bat";
      cd = "z";
      cp = "rsync-copy";
      diff = "delta";
      du = "dust";
      df = "duf";
      easd = "/Users/tharakadesilva/git_tree/expo/eas-cli/bin/run";
      edit = "cursor";
      find = "fd";
      grep = "rg";
      ls = "eza -la";
      mkdir = "take";
      mv = "rsync-move";
      rm = "rip";
      ps = "procs";
      top = "btm";
      vi = "nvim";
      vim = "nvim";
    };
  };
}
