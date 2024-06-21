{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wine
    (lutris.override {
      extraPkgs = pkgs: [
        gnome3.adwaita-icon-theme
      ];
    })
  ];
}
