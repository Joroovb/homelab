{
  inputs,
  outputs,
  vars,
  ...
}: {
  imports = [
    inputs.home-manager.darwinModules.home-manager
    ./hardware-configuration.nix
    ./../../modules/macos/base.nix
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs vars;};
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${vars.userName} = {
        imports = [
          ./../../modules/home-manager/base.nix
          ./../../modules/home-manager/git.nix
        ];
      };
    };
  };

  networking = {
    hostName = "workbook";
    computerName = "workbook";
    localHostName = "workbook";
  };
}
