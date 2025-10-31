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
    taps = builtins.attrNames config.nix-homebrew.taps;
    brews = [
      "mas"
      # The following are needed for Expo:
      "ca-certificates"
      "cocoapods"
      "libyaml"
      "openssl@3"
      "ruby"
      # End of Expo requirements
    ];
    casks = pkgs.callPackage ./casks.nix {};
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

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
      "Docko Pets" = 6743445976;
      "Okta Verify" = 490179405;
      "Say No to Notch" = 1639306886;
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
        packages =
          [
            (pkgs.python3.withPackages (ppkgs: [
              ppkgs.setuptools
            ]))
          ]
          ++ (pkgs.callPackage ./packages.nix {});
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
            mutableExtensionsDir = true;
            profiles.default = {
              extensions = [
                # TODO: Create a ticket to add this extension
                # pkgs.vscode-extensions.sourcegraph.amp
                pkgs.vscode-extensions.formulahendry.auto-rename-tag # Auto Rename Tag
                pkgs.vscode-extensions.bazelbuild.vscode-bazel # Bazel
                pkgs.vscode-extensions.biomejs.biome # Biome
                pkgs.vscode-extensions.streetsidesoftware.code-spell-checker # Code Spell Checker
                pkgs.vscode-extensions.ms-vscode-remote.remote-containers # Dev Containers
                pkgs.vscode-extensions.ms-azuretools.vscode-docker # Docker
                pkgs.vscode-extensions.editorconfig.editorconfig # EditorConfig
                pkgs.vscode-extensions.dbaeumer.vscode-eslint # ESLint
                # TODO: Create a ticket to add this extension
                # pkgs.vscode-extensions.bdsoftware.format-on-auto-save # Format on Auto Save
                pkgs.vscode-extensions.github.vscode-pull-request-github # GitHub Pull Request
                pkgs.vscode-extensions.github.github-vscode-theme # GitHub Theme
                pkgs.vscode-extensions.golang.go # Go
                # TODO: Create a ticket to add this extension
                # pkgs.vscode-extensions.RobertOstermann.inline-parameters-extended # Inline Parameters Extended
                pkgs.vscode-extensions.k--kato.intellij-idea-keybindings # IntelliJ IDEA Keybindings
                pkgs.vscode-extensions.ms-python.isort # isort (Import Sorting)
                pkgs.vscode-extensions.pkief.material-icon-theme # Material Icon Theme
                pkgs.vscode-extensions.bbenoist.nix # Nix
                pkgs.vscode-extensions.christian-kohler.path-intellisense # Path Intellisense
                pkgs.vscode-extensions.esbenp.prettier-vscode # Prettier
                pkgs.vscode-extensions.ms-python.vscode-pylance # Pylance
                pkgs.vscode-extensions.ms-python.python # Python
                # TODO: https://github.com/NixOS/nixpkgs/issues/371247
                # pkgs.vscode-extensions.swmansion.react-native-ide # Radon
                pkgs.vscode-extensions.ms-python.debugpy # Debugpy
                pkgs.vscode-extensions.ms-vscode-remote.vscode-remote-extensionpack # Remote Development
                pkgs.vscode-extensions.redhat.vscode-yaml # YAML
              ];
              userSettings = {
                "amp.url" = "https://ampcode.com/";
                "amp.tab.enabled" = true;
                "amp.permissions" = [
                  {
                    "tool" = "*";
                    "action" = "allow";
                  }
                ];
                "bazel.buildifierExecutable" = "${pkgs.buildifier}/bin/buildifier";
                "bazel.buildifierFixOnFormat" = true;
                "cSpell.userWords" = [
                  "tharakadesilva"
                ];
                "diffEditor.ignoreTrimWhitespace" = false;
                "diffEditor.renderSideBySide" = false;
                "editor.inlineSuggest.enabled" = true;
                "editor.fontFamily" = "'JetbrainsMono Nerd Font Mono'";
                "editor.fontSize" = 13;
                "editor.formatOnPaste" = true;
                "editor.formatOnSave" = true;
                "editor.formatOnType" = true;
                "editor.suggestSelection" = "first";
                "explorer.confirmDelete" = false;
                "files.autoSave" = "afterDelay";
                "files.autoSaveDelay" = 2000;
                "git" = {
                  "autofetch" = true;
                  "confirmSync" = false;
                };
                "github.copilot.enable" = {
                  "*" = false;
                };
                "json.schemas" = [];
                "RadonIDE.panelLocation" = "side-panel";
                "terminal.integrated.fontFamily" = "'JetbrainsMono Nerd Font Mono'";
                "terminal.integrated.fontSize" = 13;
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
                "[javascript]" = {
                  "editor.defaultFormatter" = "vscode.typescript-language-features";
                };
                "[javascriptreact]" = {
                  "editor.defaultFormatter" = "vscode.typescript-language-features";
                };
                "[json]" = {
                  "editor.defaultFormatter" = "vscode.json-language-features";
                };
                "[jsonc]" = {
                  "editor.defaultFormatter" = "vscode.json-language-features";
                };
                "[typescript]" = {
                  "editor.defaultFormatter" = "vscode.typescript-language-features";
                };
                "[typescriptreact]" = {
                  "editor.defaultFormatter" = "vscode.typescript-language-features";
                };
              };
            };
          };
        };

      services.gpg-agent = {
        enable = true;
        pinentry.package = pkgs.pinentry_mac;
      };
    };
  };
}
