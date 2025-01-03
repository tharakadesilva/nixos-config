{
  config,
  pkgs,
  lib,
  home-manager,
  ...
}: let
  user = "tharakadesilva";
  nixRoot = "/nix/var/nix/profiles/default";
  sharedPrograms = import ../shared/home-manager.nix {inherit config pkgs lib nixRoot;};
  sharedFiles = import ../shared/files.nix {inherit config pkgs;};
  additionalFiles = import ./files.nix {inherit user config pkgs;};
in {
  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix {};
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    onActivation.cleanup = "zap";

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)

    masApps = {
      "Magnet" = 441258766;
      "Xcode" = 497799835;
    };
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = {
      pkgs,
      config,
      lib,
      ...
    }: {
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix {};
        file = lib.mkMerge [
          sharedFiles
          additionalFiles
        ];

        stateVersion = "23.11";
      };
      programs =
        sharedPrograms
        // {
          vscode = {
            enable = true;
            mutableExtensionsDir = false;
            extensions = [
              pkgs.vscode-extensions.formulahendry.auto-rename-tag # Auto Rename Tag
              pkgs.vscode-extensions.bazelbuild.vscode-bazel # Bazel
              pkgs.vscode-extensions.streetsidesoftware.code-spell-checker # Code Spell Checker
              pkgs.vscode-extensions.ms-vscode-remote.remote-containers # Dev Containers
              pkgs.vscode-extensions.ms-azuretools.vscode-docker # Docker
              pkgs.vscode-extensions.editorconfig.editorconfig # EditorConfig
              pkgs.vscode-extensions.dbaeumer.vscode-eslint # ESLint
              pkgs.vscode-extensions.github.vscode-pull-request-github # GitHub Pull Request
              pkgs.vscode-extensions.github.github-vscode-theme # GitHub Theme
              pkgs.vscode-extensions.golang.go # Go
              pkgs.vscode-extensions.k--kato.intellij-idea-keybindings # IntelliJ IDEA Keybindings
              pkgs.vscode-extensions.ms-python.isort # isort (Import Sorting)
              pkgs.vscode-extensions.equinusocio.vsc-material-theme-icons # Material Icon Theme
              pkgs.vscode-extensions.bbenoist.nix # Nix
              pkgs.vscode-extensions.christian-kohler.path-intellisense # Path Intellisense
              pkgs.vscode-extensions.esbenp.prettier-vscode # Prettier
              pkgs.vscode-extensions.ms-python.vscode-pylance # Pylance
              pkgs.vscode-extensions.ms-python.python # Python
              pkgs.vscode-extensions.ms-python.debugpy # Debugpy
              pkgs.vscode-extensions.redhat.vscode-yaml # YAML
            ];
            userSettings = {
              "cSpell.userWords" = [
                "bgcolor"
                "clsx"
                "dtype"
                "MACD"
                "notistack"
                "Stoch"
                "taapi"
                "tharakadesilva"
              ];
              "diffEditor.ignoreTrimWhitespace" = false;
              "editor.fontFamily" = "'JetbrainsMono Nerd Font'";
              "editor.inlineSuggest.enabled" = true;
              "editor.suggestSelection" = "first";
              "explorer.confirmDelete" = false;
              "files.autoSave" = "afterDelay";
              "json.schemas" = [];
              "terminal.integrated.fontFamily" = "JetbrainsMono Nerd Font";
              "typescript.updateImportsOnFileMove.enabled" = "always";
              "workbench.colorTheme" = "GitHub Dark Default";
              "workbench.iconTheme" = "material-icon-theme";
              "yaml.customTags" = [
                "!And"
                "!And sequence"
                "!Base64"
                "!Cidr"
                "!Equals"
                "!Equals sequence"
                "!FindInMap"
                "!FindInMap sequence"
                "!GetAtt"
                "!GetAZs"
                "!If"
                "!If sequence"
                "!ImportValue"
                "!ImportValue sequence"
                "!Join"
                "!Join sequence"
                "!Not"
                "!Not sequence"
                "!Or"
                "!Or sequence"
                "!Ref"
                "!Select"
                "!Select sequence"
                "!Split"
                "!Split sequence"
                "!Sub"
                "!Sub sequence"
              ];
              "yaml.schemas" = {};
            };
          };
        };
    };
  };
}
