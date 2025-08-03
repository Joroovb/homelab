{
  pkgs,
  vars,
  ...
}: {
  imports = [
    ./_dock.nix
    ./_packages.nix
  ];

  nix = {
    enable = false;
  };

  # inspo: https://github.com/nix-darwin/nix-darwin/issues/1339
  ids.gids.nixbld = 350;

  programs.bash.enable = true;
  security.pam.services.sudo_local.touchIdAuth = true;

  users.users.${vars.userName} = {
    home = "/Users/${vars.userName}";
    shell = pkgs.bashInteractive;
  };

  system = {
    primaryUser = vars.userName;
    startup.chime = false;
    defaults = {
      loginwindow.LoginwindowText = "If lost, contact ${vars.userEmail}";

      dock = {
        autohide = true;
        mru-spaces = false;
        tilesize = 24;
        wvous-br-corner = 4;
        wvous-bl-corner = 11;
        wvous-tr-corner = 5;
      };

      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "Nlsv";
      };

      menuExtraClock = {
        ShowSeconds = false;
        Show24Hour = true;
        ShowAMPM = false;
      };

      NSGlobalDomain = {
        AppleICUForce24HourTime = true;
        AppleInterfaceStyle = "Dark";
        # inspo: https://apple.stackexchange.com/questions/261163/default-value-for-nsglobaldomain-initialkeyrepeat
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
      };
    };
  };

  local = {
    dock = {
      enable = true;
      username = vars.userName;
      entries = [
        {path = "/Applications/Alacritty.app";}
        {path = "/System/Applications/Messages.app";}
        {path = "/System/Applications/System Settings.app";}
      ];
    };
  };

  system.stateVersion = 4;
}
