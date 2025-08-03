{
  config,
  pkgs,
  vars,
  ...
}: {
  nixarr = {
    enable = true;
    mediaDir = "/content";
    stateDir = "/var/lib/nixarr";

    bazarr.enable = true;
    prowlarr.enable = true;
    radarr.enable = true;
    recyclarr.enable = true;
    sonarr.enable = true;

    transmission = {
      enable = true;
      package = pkgs.transmission_4;
      peerPort = 46634;
      extraSettings = {
        incomplete-dir-enabled = false;
        speed-limit-up = 500;
        speed-limit-up-enabled = true;
        rpc-authentication-required = true;
        rpc-username = vars.userName;
        rpc-whitelist-enabled = false;
        # todo: figure out how to integrate rpc-password into sops-nix
        rpc-password = "{7d827abfb09b77e45fe9e72d97956ab8fb53acafoPNV1MpJ";
      };
    };
  };
}
