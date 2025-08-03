{
  config,
  pkgs,
  vars,
  ...
}: {
  filesystems."/content" = {
    device = "192.168.1.16:/Public";
    fsType = "nfs";
  };

  nixarr = {
    enable = true;
    mediaDir = "/content";
    stateDir = "/var/lib/nixarr";

    jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}
