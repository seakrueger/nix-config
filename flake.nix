{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
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
        layout = "us";
      };

      userSettings = {
        primaryUser = "general";
        primaryGroups = [ "networkmanager" "wheel" ];

        name = "Sean Krueger";
        email = "skrueger2270@gmail.com";

        firefox = {
          manage = {
            settings = true;
            extensions = true;
            UI = true;
          };
        };
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


      nixosConfigurations.framework = nixpkgs.lib.nixosSystem {
          modules = [ 
            ./profiles/framework/configuration.nix
            inputs.home-manager.nixosModules.default
            inputs.nixos-hardware.nixosModules.framework-13-7040-amd
          ];
          specialArgs = {
            inherit inputs;
            inherit userSettings;
            inherit systemSettings;
            profile = "framework";
          };
        };
    };
}
