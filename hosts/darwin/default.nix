{ agenix, config, pkgs, ... }:

let user = "tharakadesilva"; in

{

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
      trusted-users = [ "@admin" "${user}" ];
      substituters = [ "https://nix-community.cachix.org" "https://cache.nixos.org" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    };

    gc = {
      user = "root";
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
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
  environment.systemPackages = with pkgs; [
    emacs-unstable
    agenix.packages."${pkgs.system}".default
  ] ++ (import ../../modules/shared/packages.nix { inherit pkgs; });

  launchd.user.agents.emacs.path = [ config.environment.systemPath ];
  launchd.user.agents.emacs.serviceConfig = {
    KeepAlive = true;
    ProgramArguments = [
      "/bin/sh"
      "-c"
      "/bin/wait4path ${pkgs.emacs}/bin/emacs && exec ${pkgs.emacs}/bin/emacs --fg-daemon"
    ];
    StandardErrorPath = "/tmp/emacs.err.log";
    StandardOutPath = "/tmp/emacs.out.log";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  system = {
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleICUForce24HourTime = true;
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;

         # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.keyboard.fnState" = true;
        "com.apple.mouse.tapBehavior" = 1;
      };

      controlcenter.BatteryShowPercentage = true;

      dock = {
        autohide = true;
        mru-spaces = false;
        show-recents = false;
        persistent-apps = [
          "/Applications/1Password.app"
          "/Applications/Google Chrome.app"
          "/Applications/Cursor.app"
          "/Applications/Warp.app"
          "/Applications/WhatsApp.app"
        ];
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        FXPreferredViewStyle = "clmv";
      };

      loginwindow.GuestEnabled = false;

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };

    activationScripts.extraActivation.text = ''
      softwareupdate --install-rosetta --agree-to-license
    '';
  };

  security.pam.enableSudoTouchIdAuth = true;
}
