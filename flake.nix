{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      systemSettings = {
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${systemSettings.system};
      };
    in
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
          modules = [ 
            ./profiles/desktop/configuration.nix
            # inputs.home-manager.nixosModules.desktop
          ];
          specialArgs = {
            inherit inputs;
            systemSettings = let inherit systemSettings; in {
                                profile = "desktop";
                             };
          };
        };

    };
}
