{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      systemSettings = {
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${systemSettings.system};

        timeZone = "America/Chicago";
        locale = "en_US.UTF-8";
      };

      userSettings = {
        primaryUser = "general";
        primaryGroups = [ "networkmanager" "wheel" ];

        name = "Sean Krueger";
        email = "skrueger2270@gmail.com";
      };
    in
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
          modules = [ 
            ./profiles/desktop/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
          specialArgs = {
            inherit inputs;
            inherit userSettings;
            inherit systemSettings;
            profile = "desktop";
          };
        };

    };
}
