{
  config,
  inputs,
  vars,
  ...
}: {
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    autoMigrate = true;
    user = vars.userName;
    mutableTaps = false;
    taps = {
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-core" = inputs.homebrew-core;
    };
  };

  homebrew = {
    enable = true;
    global = {
      autoUpdate = true;
    };
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    brews = [
      "neovim"
      "superfile"
      "tmux"
    ];
    taps = builtins.attrNames config.nix-homebrew.taps;
    casks = [
      "alacritty"
      "alfred"
      "intellij-idea"
      "signal"
      "microsoft-teams"
      "visual-studio-code"
      "tailscale"
      "whatsapp"
    ];

    masApps = {
    };
  };
}
