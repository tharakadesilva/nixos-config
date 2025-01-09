{
  agenix,
  config,
  pkgs,
  ...
}: let
  user = "tharakadesilva";
in {
  imports = [
    ../../modules/darwin/secrets.nix
    ../../modules/darwin/home-manager.nix
    ../../modules/shared
    agenix.darwinModules.default
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Setup user, packages, programs
  nix = {
    package = pkgs.nix;
    settings = {
      trusted-users = ["@admin" "${user}"];
      substituters = ["https://nix-community.cachix.org" "https://cache.nixos.org"];
      trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="];
    };

    gc = {
      user = "root";
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 7d";
    };

    optimise = {
      automatic = true;
    };

    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;

  # Load configuration that is shared across systems
  environment.systemPackages = with pkgs;
    [
      agenix.packages."${pkgs.system}".default
    ]
    ++ (import ../../modules/shared/packages.nix {inherit pkgs;});

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  system = {
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        "com.apple.keyboard.fnState" = true;
        "com.apple.mouse.tapBehavior" = 1;

        AppleICUForce24HourTime = true;
        AppleInterfaceStyle = "Dark";
        ApplePressAndHoldEnabled = true;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;
        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
      };

      controlcenter.BatteryShowPercentage = true;

      dock = {
        autohide = true;
        mru-spaces = false;
        show-recents = false;
        persistent-apps = [
          "/System/Applications/FaceTime.app"
          "/System/Applications/Messages.app"
          "/System/Applications/App Store.app"
          "/System/Applications/System Settings.app"
          "/Applications/1Password.app"
          "/Applications/Plex.app"
          "/Applications/Spotify.app"
          "/Applications/Slack.app"
          "/Applications/Discord.app"
          "/Applications/WhatsApp.app"
          "/Applications/Google Chrome.app"
          "/Applications/Cursor.app"
          "/Applications/Warp.app"
        ];
        persistent-others = [
          "${config.users.users.${user}.home}/Downloads"
        ];
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        FXPreferredViewStyle = "clmv";
        FXRemoveOldTrashItems = true;
        ShowPathbar = true;
      };

      loginwindow = {
        DisableConsoleAccess = true;
        GuestEnabled = false;
      };

      trackpad = {
        Clicking = true;
      };

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;
}
