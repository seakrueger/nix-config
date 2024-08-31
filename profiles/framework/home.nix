{ config, pkgs, userSettings, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.primaryUser;
  home.homeDirectory = "/home/${userSettings.primaryUser}";

  imports =
    [
      ./../../modules/home-manager/shell/bash.nix
      ./../../modules/home-manager/shell/font.nix
      ./../../modules/home-manager/shell/git.nix
      ./../../modules/home-manager/shell/vim.nix
      ./../../modules/home-manager/shell/starship.nix

      ./../../modules/home-manager/app/kitty.nix
      ./../../modules/home-manager/app/firefox.nix
    ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "23.11"; # Please read the comment before changing.
}
