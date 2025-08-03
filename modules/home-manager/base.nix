{
  lib,
  pkgs,
  vars,
  ...
}: {
  imports = [
    ./bash.nix
  ];

  home = {
    username = vars.userName;
    packages = with pkgs; [
      just
      eza
      ripgrep
      bat
      statix
    ];

    stateVersion = "25.05";
  };
}
