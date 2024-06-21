{ config, pkgs, ... }:

{
  imports = 
    [
      ./steam.nix
      ./lutris.nix
    ]; 

  environment.systemPackages = with pkgs; [
    prismlauncher
    xonotic
  ];
}
