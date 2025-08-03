{pkgs, vars, ...}: let
  installScript = import ./install.nix {inherit pkgs;};
in {
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = [
    	vars.sshPublic
    ];
  };

  environment.systemPackages = [
    installScript.config.packages.installScript
  ];

  security.sudo.wheelNeedsPassword = false;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  services.openssh = {
    enable = true;
  };

  system.stateVersion = "25.05";
}
