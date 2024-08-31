{ config, pkgs, userSettings, ... }:

{
  home.packages = with pkgs; [
    (pkgs.nerdfonts.override {
      fonts = [
        "Meslo"
        "ShareTechMono"
      ];
    })
  ];

  fonts.fontconfig.enable = true;
}
