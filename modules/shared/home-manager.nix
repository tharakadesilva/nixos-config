{ config, pkgs, lib, ... }:

let name = "Tharaka De Silva";
    user = "tharakadesilva";
    email = "tharaka.uo@gmail.com";
in
{
  # Shared shell configuration
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
        # Uncomment the following line to enable command auto-correction.
        ENABLE_CORRECTION="true"

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
        "gpg-agent"
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
        "thefuck"
        "universalarchive"
        "urltools"
        "vscode"
        "xcode"
        "yarn"
        "zoxide"
      ];
    };

    autosuggestion = {
      enable = true;
    };

    syntaxHighlighting = {
      enable = true;
    };

    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      fpath+=${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/zsh-completions/src
    '';

    envExtra = ''
      export ARCHFLAGS="-arch $(uname -m)"
      export EDITOR="cursor"
      export LANG=en_US.UTF-8
      export LC_ALL=en_US.UTF-8
    '';

    shellGlobalAliases = {
      cat = "bat";
      cd = "z"; 
      cp = "rsync-copy";
      diff = "delta";
      du = "dust";
      df = "duf";
      easd = "/Users/taraka/git_tree/expo/eas-cli/bin/run";
      edit = "cursor";
      find = "fd";
      grep = "rg";
      ls = "eza";
      mv = "rsync-move";
      rm = "rip";
      ps = "procs";
      top = "btm";
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
        "$username"
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
        deleted = "[✘\${count}](italic red)";
        diverged = "[⇕ ⇡\${ahead_count} ⇣\${behind_count}](italic bright-magenta)";
        modified = "[!\${count}](italic yellow)";
        renamed = "[»\${count}](italic bright-blue)";
        staged = "[+\${count}](italic bright-cyan)";
        stashed = "[=\${count}](italic white)";
        untracked = "[?\${count}](italic bright-yellow)";
      };

      kubernetes = {
        disabled = false;
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

      time = {
        disabled = false;
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

  git = {
    enable = true;
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
        editor = "cursor -w";
        pager = "delta";
        autocrlf = "input";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      delta = {
        navigate = true;
        line-numbers = true;
        hyperlinks-file-link-format = "cursor://file/{path}:{line}";
      };
      commit.gpgsign = true;
      pull.rebase = true;
      rebase.autoStash = true;
      merge.conflictStyle = "zdiff3";
    };
  };

  ssh = {
    enable = true;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "/home/${user}/.ssh/id_github"
          )
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "/Users/${user}/.ssh/id_github"
          )
        ];
      };
    };
  };
}
