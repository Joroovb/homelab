{
  pkgs,
  vars,
  ...
}: {
  hardware.bluetooth.enable = true;

  networking.networkmanager.enable = true;

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
  ];
}
