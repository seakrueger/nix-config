{ config, pkgs, ... }:

{
  imports = 
    [
      ./steam.nix
      ./lutris.nix
      ./xonotic.nix
    ]; 
}
