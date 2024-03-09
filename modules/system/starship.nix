{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.starship ];
}
