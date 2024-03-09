{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.xonotic
  ];
}
