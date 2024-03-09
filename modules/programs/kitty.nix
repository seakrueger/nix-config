{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.kitty ];
}
