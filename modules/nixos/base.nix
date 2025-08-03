{
  inputs,
  config,
  pkgs,
  vars,
  ...
}: {
  imports = [
    ./_packages.nix
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  networking.firewall.enable = true;

  services.openssh = {
    enable = true;
  };
  services.udev.packages = [pkgs.yubikey-personalization];

  programs.gnupg.agent = {
	enable = true;
	enableSSHSupport = true;
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
    efi.canTouchEfiVariables = true;
    timeout = 5;
  };

  users.users.${vars.userName} = {
    isNormalUser = true;
    description = vars.userName;
    extraGroups = ["wheel"];
  };

  system.stateVersion = "25.05";
}
