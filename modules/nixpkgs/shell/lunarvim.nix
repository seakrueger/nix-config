{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lunarvim
  ];
}
