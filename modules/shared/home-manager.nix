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
        "chucknorris"
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
        "zsh-autosuggestions"
        "zsh-completions"
        "zsh-syntax-highlighting"
      ];
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
    # https://starship.rs/presets/gruvbox-rainbow
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      format = lib.concatStrings [
        "[](color_orange)"
        "$os"
        "$username"
        "[](bg:color_yellow fg:color_orange)"
        "$directory"
        "[](fg:color_yellow bg:color_aqua)"
        "$git_branch"
        "$git_status"
        "[](fg:color_aqua bg:color_blue)"
        "$c"
        "$rust"
        "$golang"
        "$nodejs"
        "$php"
        "$java"
        "$kotlin"
        "$haskell"
        "$python"
        "[](fg:color_blue bg:color_bg3)"
        "$docker_context"
        "$conda"
        "[](fg:color_bg3 bg:color_bg1)"
        "$time"
        "[ ](fg:color_bg1)"
        "$line_break$character"
      ];

      palette = "gruvbox_dark";

      palettes.gruvbox_dark = {
        color_fg0 = "#fbf1c7";
        color_bg1 = "#3c3836";
        color_bg3 = "#665c54";
        color_blue = "#458588";
        color_aqua = "#689d6a";
        color_green = "#98971a";
        color_orange = "#d65d0e";
        color_purple = "#b16286";
        color_red = "#cc241d";
        color_yellow = "#d79921";
      };

      os = {
        disabled = false;
        style = "bg:color_orange fg:color_fg0";
        symbols = {
          Windows = "󰍲";
          Ubuntu = "󰕈";
          SUSE = "";
          Raspbian = "󰐿";
          Mint = "󰣭";
          Macos = "󰀵";
          Manjaro = "";
          Linux = "󰌽";
          Gentoo = "󰣨";
          Fedora = "󰣛";
          Alpine = "";
          Amazon = "";
          Android = "";
          Arch = "󰣇";
          Artix = "󰣇";
          EndeavourOS = "";
          CentOS = "";
          Debian = "󰣚";
          Redhat = "󱄛";
          RedHatEnterprise = "󱄛";
          Pop = "";
        };
      };

      username = {
        show_always = true;
        style_user = "bg:color_orange fg:color_fg0";
        style_root = "bg:color_orange fg:color_fg0";
        format = "[ $user ]($style)";
      };

      directory = {
        style = "fg:color_fg0 bg:color_yellow";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = "󰝚 ";
          "Pictures" = " ";
          "Developer" = "󰲋 ";
        };
      };

      git_branch = {
        symbol = "";
        style = "bg:color_aqua";
        format = "[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)";
      };

      git_status = {
        style = "bg:color_aqua";
        format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      c = {
        symbol = " ";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      golang = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      php = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      java = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      kotlin = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      haskell = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      python = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      docker_context = {
        symbol = "";
        style = "bg:color_bg3";
        format = "[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)";
      };

      conda = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $environment) ](fg:#83a598 bg:color_bg3)]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:color_bg1";
        format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
      };

      line_break.disabled = false;

      character = {
        disabled = false;
        success_symbol = "[](bold fg:color_green)";
        error_symbol = "[](bold fg:color_red)";
        vimcmd_symbol = "[](bold fg:color_green)";
        vimcmd_replace_one_symbol = "[](bold fg:color_purple)";
        vimcmd_replace_symbol = "[](bold fg:color_purple)";
        vimcmd_visual_symbol = "[](bold fg:color_yellow)";
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
