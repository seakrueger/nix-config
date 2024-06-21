{ config, pkgs, ... }:

{
  hardware.graphics.enable32Bit = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
  };
}
